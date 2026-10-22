import 'package:drift/drift.dart';

import '../../domain/models/attachment_owner_type.dart';
import '../../domain/models/shift_template.dart';
import '../../domain/repositories/templates_repository.dart';
import '../database/app_database.dart';
import '../mappers/pay_mapper.dart';
import 'drift_attachments_repository.dart';

class DriftTemplatesRepository implements TemplatesRepository {
  DriftTemplatesRepository(this._db, this._attachments);

  final AppDatabase _db;
  final DriftAttachmentsRepository _attachments;

  @override
  Stream<List<ShiftTemplate>> watchAll() {
    final query = _db.select(_db.shiftTemplates)
      ..orderBy([
        (t) => OrderingTerm(expression: t.sortOrder),
        (t) => OrderingTerm(expression: t.title),
      ]);

    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<void> upsert(ShiftTemplate t) {
    return _db
        .into(_db.shiftTemplates)
        .insertOnConflictUpdate(
          ShiftTemplatesCompanion.insert(
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
          ),
        );
  }

  @override
  Future<void> delete(String id) {
    return _db.transaction(() async {
      final shiftIds =
          await (_db.selectOnly(_db.shifts)
                ..addColumns([_db.shifts.id])
                ..where(_db.shifts.templateId.equals(id)))
              .map((row) => row.read(_db.shifts.id)!)
              .get();

      await _attachments.deleteForOwners(AttachmentOwnerType.shift, shiftIds);
      await (_db.delete(_db.shifts)..where((s) => s.templateId.equals(id))).go();
      await (_db.delete(_db.shiftTemplates)..where((t) => t.id.equals(id))).go();
    });
  }

  ShiftTemplate _toDomain(TemplateRow row) {
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
    );
  }
}
