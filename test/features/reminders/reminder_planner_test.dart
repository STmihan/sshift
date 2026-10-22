import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/domain/models/calendar_event.dart';
import 'package:sshift/domain/models/reminder.dart';
import 'package:sshift/domain/models/shift_template.dart';
import 'package:sshift/features/reminders/reminder_planner.dart';

import '../../helpers/fixtures.dart';

void main() {
  final now = DateTime(2026, 10, 22, 12);
  final template = ShiftTemplate(id: 't1', title: 'Day', icon: 'D', color: 0, updatedAt: now);

  test('plans only upcoming reminders, sorted and limited', () {
    final shifts = [
      shiftOn(DateTime(2026, 10, 22)).copyWith(reminder: () => const Reminder.beforeStart(30)),
      shiftOn(DateTime(2026, 10, 24)).copyWith(reminder: () => const Reminder.beforeStart(60)),
      shiftOn(DateTime(2026, 10, 23)).copyWith(reminder: () => const Reminder.beforeStart(0)),
      shiftOn(DateTime(2026, 10, 25)),
    ];
    final events = [
      CalendarEvent(
        id: 'e1',
        day: DateTime(2026, 10, 23),
        title: 'Party',
        allDay: true,
        startMinute: 0,
        endMinute: 0,
        reminder: const Reminder.onDay(daysBefore: 1, minuteOfDay: 18 * 60),
        updatedAt: now,
      ),
    ];

    final planned = planReminders(shifts: shifts, events: events, templates: {'t1': template}, now: now, limit: 2);

    expect(planned.map((r) => r.at), [DateTime(2026, 10, 22, 18), DateTime(2026, 10, 23, 10)]);
    expect(planned.first.title, 'Party');
    expect(planned.last.title, 'Day');
  });
}
