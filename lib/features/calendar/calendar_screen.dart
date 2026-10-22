import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/shell/nav_bar_metrics.dart';
import '../../core/theme/dimensions.dart';
import '../../core/utils/dates.dart';
import '../../core/widgets/month_picker/month_picker.dart';
import '../schedule/day_range.dart';
import '../schedule/schedule_actions.dart';
import '../schedule/schedule_providers.dart';
import '../templates/templates_providers.dart';
import 'state/calendar_focus_controller.dart';
import 'state/first_day_of_week_provider.dart';
import 'state/paint_mode_controller.dart';
import 'widgets/calendar_header.dart';
import 'widgets/day_popover/day_popover.dart';
import 'widgets/month_grid.dart';
import 'widgets/paint_bar.dart';
import 'widgets/round_fab.dart';

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
  static const _prefetchMonths = 3;

  late final _pages = PageController(initialPage: _indexOf(today()));
  final _month = ValueNotifier<DateTime>(monthStart(today()));
  final _prefetched = <(int, int), List<ProviderSubscription<Object?>>>{};
  int? _prefetchedFirstDay;

  static int _indexOf(DateTime month) {
    return (month.year - _baseMonth.year) * 12 + month.month - 1;
  }

  static DateTime _monthAt(int index) {
    return DateTime(_baseMonth.year, _baseMonth.month + index);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _consumeFocus(ref.read(calendarFocusProvider));
    });
  }

  void _consumeFocus(DateTime? month) {
    if (month == null || !mounted) {
      return;
    }

    ref.read(calendarFocusProvider.notifier).clear();
    unawaited(_goTo(month));
  }

  @override
  void dispose() {
    for (final subscriptions in _prefetched.values) {
      for (final subscription in subscriptions) {
        subscription.close();
      }
    }

    _pages.dispose();
    _month.dispose();
    super.dispose();
  }

  void _prefetchAround(int center, int firstDayOfWeek) {
    final wanted = {
      for (var offset = -_prefetchMonths; offset <= _prefetchMonths; offset++) (center + offset, firstDayOfWeek),
    };

    _prefetched.removeWhere((key, subscriptions) {
      if (wanted.contains(key)) {
        return false;
      }

      for (final subscription in subscriptions) {
        subscription.close();
      }

      return true;
    });

    for (final key in wanted.difference(_prefetched.keys.toSet())) {
      final range = monthGridRange(_monthAt(key.$1), key.$2);

      _prefetched[key] = [
        ref.listenManual(shiftsInRangeProvider(range), (_, _) {}),
        ref.listenManual(eventsInRangeProvider(range), (_, _) {}),
      ];
    }
  }

  void _onPageChanged(int index) {
    _month.value = _monthAt(index);

    final firstDay = _prefetchedFirstDay;

    if (firstDay != null) {
      _prefetchAround(index, firstDay);
    }
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
    final month = await pickMonth(context, _month.value);

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
    ref.listen(calendarFocusProvider, (_, month) => _consumeFocus(month));
    final media = MediaQuery.of(context);
    final firstDayOfWeek = firstDayOfWeekOf(context, ref);

    if (_prefetchedFirstDay != firstDayOfWeek) {
      _prefetchedFirstDay = firstDayOfWeek;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _prefetchAround(_indexOf(_month.value), firstDayOfWeek);
        }
      });
    }

    final painting = ref.watch(paintModeProvider) != null;
    final bottomReserve = navBarBottomReserve(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: media.padding.top),
              CalendarHeader(
                month: _month,
                onPickMonth: _pickMonth,
                onToday: () => _goTo(today()),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pages,
                  scrollDirection: Axis.vertical,
                  itemCount: _monthCount,
                  allowImplicitScrolling: true,
                  onPageChanged: _onPageChanged,
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
