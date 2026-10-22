import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/domain/models/reminder.dart';

void main() {
  test('timed reminder fires before the start', () {
    const reminder = Reminder.beforeStart(30);

    expect(reminder.triggerFor(DateTime(2026, 10, 22), allDay: false, startMinute: 600), DateTime(2026, 10, 22, 9, 30));
  });

  test('day before reminder crosses midnight', () {
    const reminder = Reminder.beforeStart(24 * 60);

    expect(reminder.triggerFor(DateTime(2026, 11), allDay: false, startMinute: 60), DateTime(2026, 10, 31, 1));
  });

  test('all-day reminder uses its own time of day', () {
    const reminder = Reminder.onDay(daysBefore: 1, minuteOfDay: 9 * 60);

    expect(reminder.daysBefore, 1);
    expect(reminder.minuteOfDay, 9 * 60);
    expect(reminder.triggerFor(DateTime(2026, 10, 22), allDay: true, startMinute: 0), DateTime(2026, 10, 21, 9));
  });

  test('converting between timed and all-day keeps the meaning close', () {
    expect(const Reminder.beforeStart(24 * 60).convertedFor(allDay: true).daysBefore, 1);
    expect(const Reminder.beforeStart(15).convertedFor(allDay: true).daysBefore, 0);
    expect(const Reminder.onDay(daysBefore: 1, minuteOfDay: 540).convertedFor(allDay: false).minutesBeforeStart, 1440);
  });
}
