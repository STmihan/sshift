import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/id.dart';
import '../../domain/models/attachment.dart';
import '../../domain/repositories/attachments_repository.dart';
import '../database/app_database.dart';

class DriftAttachmentsRepository implements AttachmentsRepository {
  DriftAttachmentsRepository(this._db, {Future<Directory> Function()? root}) : _root = root ?? _defaultRoot;

  final AppDatabase _db;
  final Future<Directory> Function() _root;

  static Future<Directory> _defaultRoot() async {
    return Directory(p.join((await getApplicationDocumentsDirectory()).path, 'attachments'));
  }

  @override
  Stream<List<Attachment>> watchForShift(String shiftId) {
    final query = _db.select(_db.attachments)
      ..where((a) => a.shiftId.equals(shiftId))
      ..orderBy([(a) => OrderingTerm(expression: a.createdAt)]);

    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<Attachment> add(String shiftId, XFile file) async {
    final count = _db.attachments.id.count();
    final existing =
        await (_db.selectOnly(_db.attachments)
              ..addColumns([count])
              ..where(_db.attachments.shiftId.equals(shiftId)))
            .map((row) => row.read(count)!)
            .getSingle();

    if (existing >= Attachment.maxPerShift) {
      throw StateError('Attachment limit (${Attachment.maxPerShift}) reached');
    }

    final id = newId();
    final name = file.name.isEmpty ? p.basename(file.path) : file.name;
    final relative = p.join(shiftId, '${id}_${_safeFileName(name)}');
    final target = File(p.join((await _root()).path, relative));

    await target.parent.create(recursive: true);
    await file.saveTo(target.path);

    final attachment = Attachment(
      id: id,
      shiftId: shiftId,
      name: name,
      path: relative,
      size: await target.length(),
      createdAt: DateTime.now(),
    );

    await _db
        .into(_db.attachments)
        .insert(
          AttachmentsCompanion.insert(
            id: attachment.id,
            shiftId: shiftId,
            name: attachment.name,
            path: attachment.path,
            size: attachment.size,
            createdAt: attachment.createdAt,
          ),
        );

    return attachment;
  }

  @override
  Future<void> delete(Attachment attachment) async {
    await (_db.delete(_db.attachments)..where((a) => a.id.equals(attachment.id))).go();
    final file = File(await resolvePath(attachment));

    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<String> resolvePath(Attachment attachment) async {
    return p.join((await _root()).path, attachment.path);
  }

  Future<void> deleteForShifts(List<String> shiftIds) async {
    if (shiftIds.isEmpty) {
      return;
    }

    await (_db.delete(_db.attachments)..where((a) => a.shiftId.isIn(shiftIds))).go();
    final root = await _root();

    for (final id in shiftIds) {
      final dir = Directory(p.join(root.path, id));

      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    }
  }

  static String _safeFileName(String name) {
    return name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  Attachment _toDomain(AttachmentRow row) {
    return Attachment(
      id: row.id,
      shiftId: row.shiftId,
      name: row.name,
      path: row.path,
      size: row.size,
      createdAt: row.createdAt,
    );
  }
}
