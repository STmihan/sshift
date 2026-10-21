import '../../../core/utils/dates.dart';
import '../../../domain/models/calendar_event.dart';
import '../../../domain/models/shift.dart';
import 'template_totals.dart';

class MonthReport {
  MonthReport._(this.months);

  factory MonthReport.single(DateTime month, Iterable<Shift> shifts, Iterable<CalendarEvent> events) {
    return MonthReport.combined({monthStart(month)}, shifts, events);
  }

  factory MonthReport.combined(Set<DateTime> months, Iterable<Shift> shifts, Iterable<CalendarEvent> events) {
    final report = MonthReport._(months);

    bool covered(DateTime day) {
      return months.contains(monthStart(day));
    }

    for (final shift in shifts.where((s) => covered(s.day))) {
      report._byTemplate.putIfAbsent(shift.templateId, () => TemplateTotals(shift.templateId))
        ..count += 1
        ..minutes += shift.workedMinutes
        ..earned += shift.earned;
      report
        ..shiftCount += 1
        ..shiftMinutes += shift.workedMinutes
        ..earned += shift.earned;

      if (!shift.pay.isSet) {
        report.unpaidCount += 1;
      }
    }

    for (final event in events.where((e) => covered(e.day))) {
      report
        ..eventCount += 1
        ..eventEarned += event.earned
        ..earned += event.earned;
    }

    return report;
  }

  final Set<DateTime> months;
  final _byTemplate = <String, TemplateTotals>{};
  int earned = 0;
  int shiftCount = 0;
  int shiftMinutes = 0;
  int eventCount = 0;
  int eventEarned = 0;
  int unpaidCount = 0;

  DateTime get month => months.reduce((a, b) => a.isAfter(b) ? a : b);

  bool get isEmpty => shiftCount == 0 && eventCount == 0;

  List<TemplateTotals> get templates =>
      _byTemplate.values.toList()
        ..sort((a, b) => b.earned != a.earned ? b.earned.compareTo(a.earned) : b.count.compareTo(a.count));

  static List<MonthReport> lastMonths(
    DateTime last,
    int count,
    List<Shift> shifts,
    List<CalendarEvent> events,
  ) {
    return [
      for (var i = count - 1; i >= 0; i--) MonthReport.single(addMonths(last, -i), shifts, events),
    ];
  }
}
