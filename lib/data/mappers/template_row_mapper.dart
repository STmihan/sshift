import 'package:drift/drift.dart';

import '../../domain/models/shift_template.dart';
import '../database/app_database.dart';
import 'pay_mapper.dart';
import 'reminder_mapper.dart';

ShiftTemplate templateFromRow(TemplateRow row) {
  return ShiftTemplate(
    id: row.id,
    title: row.title,
    icon: row.icon,
    color: row.color,
    allDay: row.allDay,
    startMinute: row.startMinute,
    endMinute: row.endMinute,
    breakMinutes: row.breakMinutes,
    defaultPay: payFromColumns(row.payType, row.payAmount),
    location: row.location,
    sortOrder: row.sortOrder,
    updatedAt: row.updatedAt,
    reminder: reminderFromColumn(row.reminderOffset),
  );
}

ShiftTemplatesCompanion templateToCompanion(ShiftTemplate t) {
  return ShiftTemplatesCompanion.insert(
    id: t.id,
    title: t.title,
    icon: t.icon,
    color: t.color,
    allDay: t.allDay,
    startMinute: t.startMinute,
    endMinute: t.endMinute,
    breakMinutes: t.breakMinutes,
    payType: t.defaultPay.type.index,
    payAmount: t.defaultPay.amount,
    location: t.location,
    sortOrder: t.sortOrder,
    updatedAt: t.updatedAt,
    reminderOffset: Value(t.reminder?.offsetMinutes),
  );
}
