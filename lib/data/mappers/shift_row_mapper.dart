import 'package:drift/drift.dart';

import '../../core/utils/dates.dart';
import '../../domain/models/shift.dart';
import '../database/app_database.dart';
import 'pay_mapper.dart';
import 'reminder_mapper.dart';

Shift shiftFromRow(ShiftRow row) {
  return Shift(
    id: row.id,
    templateId: row.templateId,
    day: fromDayKey(row.day),
    allDay: row.allDay,
    startMinute: row.startMinute,
    endMinute: row.endMinute,
    breakMinutes: row.breakMinutes,
    notes: row.notes,
    location: row.location,
    pay: payFromColumns(row.payType, row.payAmount),
    updatedAt: row.updatedAt,
    reminder: reminderFromColumn(row.reminderOffset),
  );
}

ShiftsCompanion shiftToCompanion(Shift s) {
  return ShiftsCompanion.insert(
    id: s.id,
    templateId: s.templateId,
    day: dayKey(s.day),
    allDay: s.allDay,
    startMinute: s.startMinute,
    endMinute: s.endMinute,
    breakMinutes: s.breakMinutes,
    notes: s.notes,
    location: s.location,
    payType: s.pay.type.index,
    payAmount: s.pay.amount,
    updatedAt: s.updatedAt,
    reminderOffset: Value(s.reminder?.offsetMinutes),
  );
}
