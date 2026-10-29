import 'package:drift/drift.dart';

import '../../core/utils/dates.dart';
import '../../domain/models/attachment_owner_type.dart';
import '../../domain/models/calendar_event.dart';
import '../../domain/models/pay.dart';
import '../../domain/models/pay_type.dart';
import '../../domain/models/shift.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../database/app_database.dart';
import '../mappers/event_row_mapper.dart';
import '../mappers/pay_mapper.dart';
import '../mappers/shift_row_mapper.dart';
import 'drift_attachments_repository.dart';

class DriftScheduleRepository implements ScheduleRepository {
  DriftScheduleRepository(this._db, this._attachments);

  static const _recentPaysScanLimit = 100;

  final AppDatabase _db;
  final DriftAttachmentsRepository _attachments;

  @override
  Stream<List<Shift>> watchShifts(DateTime from, DateTime to) {
    return _shiftsQuery(from, to).watch().map((rows) => rows.map(shiftFromRow).toList());
  }

  @override
  Future<List<Shift>> getShifts(DateTime from, DateTime to) async {
    return (await _shiftsQuery(from, to).get()).map(shiftFromRow).toList();
  }

  @override
  Stream<List<CalendarEvent>> watchEvents(DateTime from, DateTime to) {
    final query = _db.select(_db.events)
      ..where((e) => e.day.isBiggerOrEqualValue(dayKey(from)) & e.day.isSmallerThanValue(dayKey(to)))
      ..orderBy([
        (e) => OrderingTerm(expression: e.day),
        (e) => OrderingTerm(expression: e.allDay, mode: OrderingMode.desc),
        (e) => OrderingTerm(expression: e.startMinute),
      ]);

    return query.watch().map((rows) => rows.map(eventFromRow).toList());
  }

  @override
  Future<void> upsertShift(Shift s) {
    return _db.into(_db.shifts).insertOnConflictUpdate(shiftToCompanion(s));
  }

  @override
  Future<void> deleteShift(String id) {
    return _db.transaction(() async {
      await _attachments.deleteForOwners(AttachmentOwnerType.shift, [id]);
      await (_db.delete(_db.shifts)..where((s) => s.id.equals(id))).go();
    });
  }

  @override
  Future<void> upsertEvent(CalendarEvent e) {
    return _db.into(_db.events).insertOnConflictUpdate(eventToCompanion(e));
  }

  @override
  Future<void> deleteEvent(String id) {
    return _db.transaction(() async {
      await _attachments.deleteForOwners(AttachmentOwnerType.event, [id]);
      await (_db.delete(_db.events)..where((e) => e.id.equals(id))).go();
    });
  }

  @override
  Future<List<Pay>> recentShiftPays(String templateId, {int limit = 5}) async {
    final query = _db.select(_db.shifts)
      ..where((s) => s.templateId.equals(templateId) & s.payType.isNotValue(PayType.none.index))
      ..orderBy([
        (s) => OrderingTerm(expression: s.day, mode: OrderingMode.desc),
        (s) => OrderingTerm(expression: s.updatedAt, mode: OrderingMode.desc),
      ])
      ..limit(_recentPaysScanLimit);
    final rows = await query.get();

    return distinctPays(rows.map((r) => payFromColumns(r.payType, r.payAmount)), limit);
  }

  @override
  Future<List<Pay>> recentEventPays(String title, {int limit = 5}) async {
    final query = _db.select(_db.events)
      ..where((e) => e.title.lower().equals(title.trim().toLowerCase()) & e.payType.isNotValue(PayType.none.index))
      ..orderBy([
        (e) => OrderingTerm(expression: e.day, mode: OrderingMode.desc),
        (e) => OrderingTerm(expression: e.updatedAt, mode: OrderingMode.desc),
      ])
      ..limit(_recentPaysScanLimit);
    final rows = await query.get();

    return distinctPays(rows.map((r) => payFromColumns(r.payType, r.payAmount)), limit);
  }

  SimpleSelectStatement<$ShiftsTable, ShiftRow> _shiftsQuery(DateTime from, DateTime to) {
    return _db.select(_db.shifts)
      ..where((s) => s.day.isBiggerOrEqualValue(dayKey(from)) & s.day.isSmallerThanValue(dayKey(to)))
      ..orderBy([
        (s) => OrderingTerm(expression: s.day),
        (s) => OrderingTerm(expression: s.startMinute),
      ]);
  }
}
