import '../../core/utils/dates.dart';

typedef DayRange = ({int from, int to});

DayRange dayRange(DateTime from, DateTime to) {
  return (from: dayKey(from), to: dayKey(to));
}
