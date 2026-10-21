import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/shell/nav_bar_metrics.dart';
import '../../core/theme/dimensions.dart';
import '../../core/utils/dates.dart';
import '../../core/widgets/circle_button.dart';
import '../../core/widgets/month_picker/month_picker.dart';
import '../../l10n/app_localizations.dart';
import '../schedule/schedule_actions.dart';
import '../templates/templates_providers.dart';
import 'state/first_day_of_week_provider.dart';
import 'state/paint_mode_controller.dart';
import 'widgets/day_popover/day_popover.dart';
import 'widgets/month_grid.dart';
import 'widgets/month_title.dart';
import 'widgets/paint_bar.dart';
import 'widgets/round_fab.dart';
import 'widgets/today_pill.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  static final _baseMonth = DateTime(2000);
  static const _monthCount = 200 * 12;
  static const _fabGap = 32.0;
  static const _paintBarGap = 16.0;

  late final _pages = PageController(initialPage: _indexOf(today()));
  late DateTime _month = monthStart(today());

  static int _indexOf(DateTime month) {
    return (month.year - _baseMonth.year) * 12 + month.month - 1;
  }

  static DateTime _monthAt(int index) {
    return DateTime(_baseMonth.year, _baseMonth.month + index);
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  Future<void> _goTo(DateTime month) async {
    final target = _indexOf(month);
    final current = _pages.page?.round() ?? target;

    if ((target - current).abs() > 2) {
      _pages.jumpToPage(target);
      return;
    }

    await _pages.animateToPage(target, duration: const Duration(milliseconds: 380), curve: Curves.easeOutCubic);
  }

  Future<void> _pickMonth() async {
    final month = await pickMonth(context, _month);

    if (month != null) {
      await _goTo(month);
    }
  }

  Future<void> _onDayTap(DateTime day, Rect cell) async {
    final paint = ref.read(paintModeProvider);

    if (paint == null) {
      return showDayPopover(context, ref, day, cell);
    }

    final template = ref.read(templatesByIdProvider)[paint.templateId];

    if (template != null) {
      await ref.read(scheduleActionsProvider).toggleShift(template, day);
    }
  }

  void _togglePaint() {
    final controller = ref.read(paintModeProvider.notifier);

    if (ref.read(paintModeProvider) != null) {
      controller.stop();
      return;
    }

    final templates = ref.read(templatesProvider).value ?? const [];

    controller.start(templates.isEmpty ? null : templates.first.id);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final media = MediaQuery.of(context);
    final firstDayOfWeek = firstDayOfWeekOf(context, ref);
    final painting = ref.watch(paintModeProvider) != null;
    final now = today();
    final isCurrentMonth = _month == monthStart(now);
    final bottomReserve = navBarBottomReserve(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: media.padding.top),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: Row(
                  children: [
                    CircleButton(icon: Icons.calendar_month_outlined, onTap: _pickMonth),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: _pickMonth,
                        child: MonthTitle(month: _month),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: isCurrentMonth ? 0 : 1,
                      duration: const Duration(milliseconds: 150),
                      child: IgnorePointer(
                        ignoring: isCurrentMonth,
                        child: TodayPill(label: l.today, onTap: () => _goTo(now)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pages,
                  scrollDirection: Axis.vertical,
                  itemCount: _monthCount,
                  onPageChanged: (index) => setState(() => _month = _monthAt(index)),
                  itemBuilder: (context, index) => LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(6, 0, 6, bottomReserve),
                      child: MonthGrid(
                        month: _monthAt(index),
                        firstDayOfWeek: firstDayOfWeek,
                        availableHeight: constraints.maxHeight - bottomReserve,
                        onDayTap: _onDayTap,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: navBarRightInset(media.size.width) + 1,
            bottom: navBarHeight + navBarBottomGap + _fabGap + media.padding.bottom,
            child: RoundFab(
              icon: painting ? Icons.close_rounded : Icons.edit_rounded,
              onTap: _togglePaint,
            ),
          ),
          if (painting)
            Positioned(
              left: 0,
              right: 0,
              bottom: _paintBarGap + media.padding.bottom,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: contentMaxWidth),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: PaintBar(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
