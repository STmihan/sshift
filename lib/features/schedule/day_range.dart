import '../../core/utils/dates.dart';

typedef DayRange = ({int from, int to});

DayRange monthGridRange(DateTime month, int firstDayOfWeek) {
  final start = gridStart(month, firstDayOfWeek);

  return dayRange(start, addDays(start, weeksInMonth(month, firstDayOfWeek) * 7));
}

DayRange dayRange(DateTime from, DateTime to) {
  return (from: dayKey(from), to: dayKey(to));
}
