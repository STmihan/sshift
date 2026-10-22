import 'package:flutter/foundation.dart';

import 'time_span.dart';

@immutable
class Reminder {
  const Reminder(this.offsetMinutes);

  const Reminder.beforeStart(int minutes) : offsetMinutes = -minutes;

  const Reminder.onDay({required int daysBefore, required int minuteOfDay})
    : offsetMinutes = minuteOfDay - daysBefore * minutesPerDay;

  static const defaultAllDayMinute = 9 * 60;
  static const presetsBeforeStart = [0, 5, 10, 15, 30, 60, 120, minutesPerDay];
  static const allDayDaysBefore = [0, 1];

  final int offsetMinutes;

  int get minutesBeforeStart => -offsetMinutes;

  int get daysBefore => offsetMinutes < 0 ? (-offsetMinutes + minutesPerDay - 1) ~/ minutesPerDay : 0;

  int get minuteOfDay => offsetMinutes + daysBefore * minutesPerDay;

  DateTime triggerFor(DateTime day, {required bool allDay, required int startMinute}) {
    final anchor = allDay ? 0 : startMinute;

    return DateTime(day.year, day.month, day.day, 0, anchor + offsetMinutes);
  }

  Reminder convertedFor({required bool allDay}) {
    if (allDay) {
      return Reminder.onDay(
        daysBefore: minutesBeforeStart >= minutesPerDay ? 1 : 0,
        minuteOfDay: defaultAllDayMinute,
      );
    }

    return Reminder.beforeStart(daysBefore > 0 ? minutesPerDay : 0);
  }

  @override
  bool operator ==(Object other) {
    return other is Reminder && other.offsetMinutes == offsetMinutes;
  }

  @override
  int get hashCode => offsetMinutes.hashCode;

  @override
  String toString() {
    return 'Reminder($offsetMinutes)';
  }
}
