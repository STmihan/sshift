import 'package:drift/drift.dart';

import '../../core/utils/dates.dart';
import '../../domain/models/calendar_event.dart';
import '../database/app_database.dart';
import 'pay_mapper.dart';
import 'reminder_mapper.dart';

CalendarEvent eventFromRow(EventRow row) {
  return CalendarEvent(
    id: row.id,
    day: fromDayKey(row.day),
    title: row.title,
    allDay: row.allDay,
    startMinute: row.startMinute,
    endMinute: row.endMinute,
    notes: row.notes,
    location: row.location,
    pay: payFromColumns(row.payType, row.payAmount),
    updatedAt: row.updatedAt,
    reminder: reminderFromColumn(row.reminderOffset),
  );
}

EventsCompanion eventToCompanion(CalendarEvent e) {
  return EventsCompanion.insert(
    id: e.id,
    day: dayKey(e.day),
    title: e.title,
    allDay: e.allDay,
    startMinute: e.startMinute,
    endMinute: e.endMinute,
    notes: e.notes,
    location: e.location,
    payType: e.pay.type.index,
    payAmount: e.pay.amount,
    updatedAt: e.updatedAt,
    reminderOffset: Value(e.reminder?.offsetMinutes),
  );
}
