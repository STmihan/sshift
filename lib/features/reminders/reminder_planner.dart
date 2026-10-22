import '../../domain/models/calendar_event.dart';
import '../../domain/models/shift.dart';
import '../../domain/models/shift_template.dart';
import 'pending_reminder.dart';

List<PendingReminder> planReminders({
  required List<Shift> shifts,
  required List<CalendarEvent> events,
  required Map<String, ShiftTemplate> templates,
  required DateTime now,
  required int limit,
}) {
  final planned = <PendingReminder>[];

  for (final shift in shifts) {
    final reminder = shift.reminder;

    if (reminder != null) {
      planned.add(
        PendingReminder(
          at: reminder.triggerFor(shift.day, allDay: shift.allDay, startMinute: shift.startMinute),
          day: shift.day,
          title: templates[shift.templateId]?.title,
          allDay: shift.allDay,
          startMinute: shift.startMinute,
          endMinute: shift.endMinute,
        ),
      );
    }
  }

  for (final event in events) {
    final reminder = event.reminder;

    if (reminder != null) {
      planned.add(
        PendingReminder(
          at: reminder.triggerFor(event.day, allDay: event.allDay, startMinute: event.startMinute),
          day: event.day,
          title: event.title,
          allDay: event.allDay,
          startMinute: event.startMinute,
          endMinute: event.endMinute,
        ),
      );
    }
  }

  final upcoming = planned.where((reminder) => reminder.at.isAfter(now)).toList()..sort((a, b) => a.at.compareTo(b.at));

  return upcoming.take(limit).toList();
}
