import 'dart:math' as math;

import '../../../domain/models/calendar_event.dart';
import '../../../domain/models/shift.dart';
import 'day_item.dart';

const weekdayHeaderHeight = 26.0;
const dayNumberHeight = 24.0;
const fullChipHeight = 30.0;
const lineHeight = 15.0;
const itemGap = 2.0;
const cellPadding = 5.0;
const maxDayLines = 4;
const maxFillWeekHeight = 120.0;
const minWeekHeight = dayNumberHeight + fullChipHeight + itemGap + cellPadding;

List<DayItem> dayItemsFor(List<Shift> shifts, List<CalendarEvent> events, {required bool painting}) {
  final items = <DayItem>[if (painting && shifts.isEmpty) const DayItem.slot()];

  if (events.isEmpty && shifts.length == 1) {
    return [...items, DayItem.fullShift(shifts.single)];
  }

  final lines = [for (final s in shifts) DayItem.shiftLine(s), for (final e in events) DayItem.eventLine(e)];

  if (lines.length <= maxDayLines) {
    return [...items, ...lines];
  }

  return [...items, ...lines.take(maxDayLines - 1), DayItem.more(lines.length - (maxDayLines - 1))];
}

double weekHeightFor(Iterable<List<DayItem>> days) {
  final content = days.map((items) => items.fold(0.0, (h, item) => h + item.height + itemGap)).fold(0.0, math.max);

  return math.max(minWeekHeight, dayNumberHeight + content + cellPadding);
}

List<double> fillWeekHeights(List<double> needed, double available) {
  var fill = (available / needed.length).clamp(minWeekHeight, maxFillWeekHeight);
  final tall = needed.where((h) => h > fill).toList();

  if (tall.isNotEmpty && tall.length < needed.length) {
    final rest = (available - tall.fold(0.0, (a, b) => a + b)) / (needed.length - tall.length);

    fill = rest.clamp(minWeekHeight, maxFillWeekHeight);
  }

  return [for (final h in needed) math.max(h, fill)];
}
