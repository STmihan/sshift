import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/utils/dates.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/models/calendar_event.dart';
import '../../../domain/models/shift.dart';
import '../../schedule/day_range.dart';
import '../../schedule/schedule_providers.dart';
import '../../templates/templates_providers.dart';
import '../layout/month_layout.dart';
import '../state/paint_mode_controller.dart';
import '../state/selected_day_controller.dart';
import 'day_cell.dart';

class MonthGrid extends ConsumerWidget {
  const MonthGrid({
    required this.month,
    required this.firstDayOfWeek,
    required this.availableHeight,
    required this.onDayTap,
    super.key,
  });

  final DateTime month;
  final int firstDayOfWeek;
  final double availableHeight;
  final void Function(DateTime day, Rect cellRect) onDayTap;

  bool _isWeekend(int column) {
    return const {DateTime.sunday % 7, DateTime.saturday}.contains((firstDayOfWeek + column) % 7);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final start = gridStart(month, firstDayOfWeek);
    final weeks = weeksInMonth(month, firstDayOfWeek);
    final range = monthGridRange(month, firstDayOfWeek);
    final shifts = ref.watch(shiftsInRangeProvider(range)).value ?? const [];
    final events = ref.watch(eventsInRangeProvider(range)).value ?? const [];
    final templates = ref.watch(templatesByIdProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final painting = ref.watch(paintModeProvider) != null;
    final now = today();

    final shiftsByDay = <int, List<Shift>>{};

    for (final s in shifts) {
      shiftsByDay.putIfAbsent(dayKey(s.day), () => []).add(s);
    }

    final eventsByDay = <int, List<CalendarEvent>>{};

    for (final e in events) {
      eventsByDay.putIfAbsent(dayKey(e.day), () => []).add(e);
    }

    final days = [
      for (var w = 0; w < weeks; w++) [for (var c = 0; c < 7; c++) addDays(start, w * 7 + c)],
    ];
    final items = [
      for (final week in days)
        [
          for (final d in week)
            dayItemsFor(shiftsByDay[dayKey(d)] ?? const [], eventsByDay[dayKey(d)] ?? const [], painting: painting),
        ],
    ];
    final heights = fillWeekHeights(items.map(weekHeightFor).toList(), availableHeight - weekdayHeaderHeight);

    return Container(
      decoration: BoxDecoration(color: p.card, borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var c = 0; c < 7; c++)
                  Expanded(
                    child: ColoredBox(color: _isWeekend(c) ? p.weekend : p.card),
                  ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: weekdayHeaderHeight,
                child: Row(
                  children: [
                    for (var c = 0; c < 7; c++)
                      Expanded(
                        child: Center(
                          child: Text(
                            formatWeekdayNarrow(context, (firstDayOfWeek + c) % 7),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: _isWeekend(c) ? FontWeight.w600 : FontWeight.w400,
                              color: _isWeekend(c) ? p.weekendText : p.textSecondary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              for (var w = 0; w < weeks; w++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  height: heights[w],
                  decoration: w == 0
                      ? null
                      : BoxDecoration(
                          border: Border(top: BorderSide(color: p.divider)),
                        ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var c = 0; c < 7; c++)
                        Expanded(
                          child: Builder(
                            builder: (cellContext) => DayCell(
                              day: days[w][c],
                              inMonth: days[w][c].month == month.month,
                              isToday: isSameDay(days[w][c], now),
                              isWeekend: _isWeekend(c),
                              isSelected: selectedDay == dayKey(days[w][c]),
                              painting: painting,
                              items: items[w][c],
                              templates: templates,
                              onTap: () {
                                final box = cellContext.findRenderObject()! as RenderBox;

                                onDayTap(days[w][c], box.localToGlobal(Offset.zero) & box.size);
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
