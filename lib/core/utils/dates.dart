DateTime dateOnly(DateTime d) {
  return DateTime(d.year, d.month, d.day);
}

DateTime today() {
  return dateOnly(DateTime.now());
}

DateTime addDays(DateTime d, int days) {
  return DateTime(d.year, d.month, d.day + days);
}

DateTime monthStart(DateTime d) {
  return DateTime(d.year, d.month);
}

DateTime addMonths(DateTime d, int months) {
  return DateTime(d.year, d.month + months);
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

int dayKey(DateTime d) {
  return d.year * 10000 + d.month * 100 + d.day;
}

DateTime fromDayKey(int key) {
  return DateTime(key ~/ 10000, key ~/ 100 % 100, key % 100);
}

DateTime gridStart(DateTime month, int firstDayOfWeek) {
  final first = monthStart(month);
  final offset = (first.weekday % 7 - firstDayOfWeek + 7) % 7;

  return addDays(first, -offset);
}

int weeksInMonth(DateTime month, int firstDayOfWeek) {
  final offset = monthStart(month).difference(gridStart(month, firstDayOfWeek)).inDays;
  final days = DateTime(month.year, month.month + 1, 0).day;

  return ((offset + days) / 7).ceil();
}

String isoDate(DateTime d) {
  final year = '${d.year}'.padLeft(4, '0');
  final month = '${d.month}'.padLeft(2, '0');
  final day = '${d.day}'.padLeft(2, '0');

  return '$year-$month-$day';
}
