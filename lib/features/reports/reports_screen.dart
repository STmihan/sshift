import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/shell/nav_bar_metrics.dart';
import '../../core/theme/theme_context.dart';
import '../../core/utils/dates.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/centered_content.dart';
import '../../core/widgets/circle_button.dart';
import '../../core/widgets/month_picker/month_picker.dart';
import '../../core/widgets/page_header.dart';
import '../../core/widgets/section_label.dart';
import '../../l10n/app_localizations.dart';
import '../schedule/day_range.dart';
import '../schedule/schedule_providers.dart';
import '../settings/settings_controller.dart';
import 'model/month_report.dart';
import 'widgets/arrow_button.dart';
import 'widgets/breakdown_card.dart';
import 'widgets/chart_card.dart';
import 'widgets/total_card.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() {
    return _ReportsScreenState();
  }
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  static const _chartMonths = 6;

  DateTime _anchor = monthStart(DateTime.now());
  Set<DateTime> _selected = {monthStart(DateTime.now())};

  DateTime get _latest => _selected.reduce((a, b) => a.isAfter(b) ? a : b);

  DateTime get _earliest => _selected.reduce((a, b) => a.isBefore(b) ? a : b);

  DateTime get _windowStart => addMonths(_anchor, -(_chartMonths - 1));

  void _selectSingle(DateTime month) {
    setState(() {
      _selected = {month};

      if (month.isAfter(_anchor) || month.isBefore(_windowStart)) {
        _anchor = month;
      }
    });
  }

  void _select(Set<DateTime> months) {
    if (months.length == 1) {
      _selectSingle(months.single);
      return;
    }

    setState(() {
      _selected = months;
      _anchor = _latest;
    });
  }

  void _toggle(DateTime month) {
    if (_selected.contains(month) && _selected.length == 1) {
      return;
    }

    HapticFeedback.selectionClick();
    setState(() {
      _selected = {..._selected};

      if (!_selected.remove(month)) {
        _selected.add(month);
      }
    });
  }

  Future<void> _pickMonths() async {
    final months = await pickMonths(context, _selected);

    if (months != null && months.isNotEmpty) {
      _select(months);
    }
  }

  String _selectionLabel(BuildContext context) {
    if (_selected.length == 1) {
      return formatMonthYear(context, _selected.single);
    }

    final first = _earliest;
    final last = _latest;
    final span = (last.year - first.year) * 12 + last.month - first.month + 1;

    if (span != _selected.length) {
      return AppLocalizations.of(context).monthsSelected(_selected.length);
    }

    final from = first.year == last.year ? formatMonthShort(context, first) : formatMonthYear(context, first);

    return AppLocalizations.of(context).monthRange(from, formatMonthYear(context, last));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final currency = ref.watch(settingsProvider.select((s) => s.currency));
    final from = addMonths(_earliest.isBefore(_windowStart) ? _earliest : _windowStart, -1);
    final to = addMonths(_latest.isAfter(_anchor) ? _latest : _anchor, 1);
    final range = dayRange(from, to);
    final shifts = ref.watch(shiftsInRangeProvider(range)).value ?? const [];
    final events = ref.watch(eventsInRangeProvider(range)).value ?? const [];

    final report = MonthReport.combined(_selected, shifts, events);
    final previous = _selected.length == 1 ? MonthReport.single(addMonths(_latest, -1), shifts, events) : null;
    final thisMonth = monthStart(DateTime.now());
    final isCurrentMonth = _selected.length == 1 && _selected.single == thisMonth;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.only(bottom: navBarBottomReserve(context)),
          children: [
            PageHeader(
              title: l.reportsTitle,
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    CircleButton(icon: Icons.calendar_month_outlined, size: 34, onTap: _pickMonths),
                    const SizedBox(width: 6),
                    ArrowButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: () => _selectSingle(addMonths(_earliest, -1)),
                    ),
                    Flexible(
                      child: Text(
                        _selectionLabel(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15, color: p.textSecondary),
                      ),
                    ),
                    ArrowButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: () => _selectSingle(addMonths(_latest, 1)),
                    ),
                  ],
                ),
              ),
              trailing: AnimatedOpacity(
                opacity: isCurrentMonth ? 0 : 1,
                duration: const Duration(milliseconds: 150),
                child: IgnorePointer(
                  ignoring: isCurrentMonth,
                  child: CircleButton(icon: Icons.today_rounded, onTap: () => _selectSingle(thisMonth)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CenteredContent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TotalCard(report: report, previous: previous, currency: currency),
                    const SizedBox(height: 12),
                    ChartCard(
                      reports: MonthReport.lastMonths(_anchor, _chartMonths, shifts, events),
                      selected: _selected,
                      onSelect: _selectSingle,
                      onToggle: _toggle,
                    ),
                    if (!report.isEmpty) ...[
                      SectionLabel(l.byShiftType),
                      BreakdownCard(report: report, currency: currency),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
