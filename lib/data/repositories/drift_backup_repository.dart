import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import '../../domain/models/attachment.dart';
import '../../domain/models/attachment_owner_type.dart';
import '../../domain/models/backup_info.dart';
import '../../domain/models/backup_snapshot.dart';
import '../../domain/models/backup_stats.dart';
import '../../domain/repositories/backup_repository.dart';
import '../backup/backup_archive.dart';
import '../backup/backup_document.dart';
import '../database/app_database.dart';
import '../mappers/attachment_row_mapper.dart';
import '../mappers/event_row_mapper.dart';
import '../mappers/shift_row_mapper.dart';
import '../mappers/template_row_mapper.dart';
import 'drift_attachments_repository.dart';

class DriftBackupRepository implements BackupRepository {
  DriftBackupRepository(this._db, this._attachments, this._workDirectory);

  static const _exportFolder = 'export';
  static const _stagingSuffix = '_import';
  static const _retiredSuffix = '_old';

  final AppDatabase _db;
  final DriftAttachmentsRepository _attachments;
  final Future<Directory> Function() _workDirectory;

  @override
  Future<BackupStats> currentStats() async {
    return BackupStats.of(await _readSnapshot(includeAttachments: true));
  }

  @override
  Future<String> export({required bool includeAttachments, required String appVersion}) async {
    final snapshot = await _readSnapshot(includeAttachments: includeAttachments);
    final document = BackupDocument(appVersion: appVersion, exportedAt: DateTime.now(), snapshot: snapshot);
    final files = {for (final a in snapshot.attachments) a.id: await _attachments.resolvePath(a)};
    final directory = Directory(p.join((await _workDirectory()).path, _exportFolder));

    await _deleteIfExists(directory);
    await directory.create(recursive: true);
    final target = p.join(directory.path, backupFileName(document.exportedAt));

    await _write(target, document, files);

    return target;
  }

  @override
  Future<BackupInfo> inspect(String path) async {
    final document = await _read(path);

    return BackupInfo(
      appVersion: document.appVersion,
      exportedAt: document.exportedAt,
      stats: BackupStats.of(document.snapshot),
    );
  }

  @override
  Future<void> restore(String path) async {
    final root = await _attachments.rootDirectory();
    final staging = Directory('${root.path}$_stagingSuffix');
    final retired = Directory('${root.path}$_retiredSuffix');

    await _deleteIfExists(staging);
    await _deleteIfExists(retired);
    await staging.create(recursive: true);

    try {
      final document = await _extract(path, staging.path);

      await _replaceRows(document.snapshot);
    } on Object {
      await _deleteIfExists(staging);
      rethrow;
    }

    if (await root.exists()) {
      await root.rename(retired.path);
    }

    await staging.rename(root.path);
    await _deleteIfExists(retired);
  }

  Future<void> _replaceRows(BackupSnapshot snapshot) {
    return _db.transaction(() async {
      await _db.delete(_db.attachments).go();
      await _db.delete(_db.shifts).go();
      await _db.delete(_db.events).go();
      await _db.delete(_db.shiftTemplates).go();
      await _db.batch((batch) {
        batch.insertAll(_db.shiftTemplates, snapshot.templates.map(templateToCompanion));
        batch.insertAll(_db.shifts, snapshot.shifts.map(shiftToCompanion));
        batch.insertAll(_db.events, snapshot.events.map(eventToCompanion));
        batch.insertAll(_db.attachments, snapshot.attachments.map(attachmentToCompanion));
      });
    });
  }

  Future<BackupSnapshot> _readSnapshot({required bool includeAttachments}) async {
    final templates = await (_db.select(
      _db.shiftTemplates,
    )..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).get();
    final templateIds = {for (final t in templates) t.id};
    final allShifts = await (_db.select(_db.shifts)..orderBy([(s) => OrderingTerm(expression: s.day)])).get();
    final shifts = allShifts.where((s) => templateIds.contains(s.templateId)).toList();
    final events = await (_db.select(_db.events)..orderBy([(e) => OrderingTerm(expression: e.day)])).get();
    final owners = {
      AttachmentOwnerType.shift: {for (final s in shifts) s.id},
      AttachmentOwnerType.event: {for (final e in events) e.id},
    };

    return BackupSnapshot(
      templates: templates.map(templateFromRow).toList(),
      shifts: shifts.map(shiftFromRow).toList(),
      events: events.map(eventFromRow).toList(),
      attachments: includeAttachments ? await _storedAttachments(owners) : const [],
    );
  }

  Future<List<Attachment>> _storedAttachments(Map<AttachmentOwnerType, Set<String>> owners) async {
    final rows = await (_db.select(_db.attachments)..orderBy([(a) => OrderingTerm(expression: a.createdAt)])).get();
    final stored = <Attachment>[];

    for (final attachment in rows.map(attachmentFromRow)) {
      final owned = owners[attachment.owner.type]!.contains(attachment.owner.id);

      if (owned && await File(await _attachments.resolvePath(attachment)).exists()) {
        stored.add(attachment);
      }
    }

    return stored;
  }

  static Future<void> _write(String target, BackupDocument document, Map<String, String> files) {
    return Isolate.run(() => writeBackupArchive(target: target, document: document, attachmentFiles: files));
  }

  static Future<BackupDocument> _read(String path) {
    return Isolate.run(() => readBackupArchive(path));
  }

  static Future<BackupDocument> _extract(String path, String attachmentsRoot) {
    return Isolate.run(() => extractBackupArchive(path, attachmentsRoot));
  }

  static Future<void> _deleteIfExists(Directory directory) async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}
