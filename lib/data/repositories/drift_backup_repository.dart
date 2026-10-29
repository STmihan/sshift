import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import '../../domain/models/attachment.dart';
import '../../domain/models/attachment_owner_type.dart';
import '../../domain/models/backup_import_mode.dart';
import '../../domain/models/backup_info.dart';
import '../../domain/models/backup_snapshot.dart';
import '../../domain/models/backup_stats.dart';
import '../../domain/repositories/backup_repository.dart';
import '../backup/backup_additions.dart';
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
    return BackupStats.of(await _exportableSnapshot(includeAttachments: true));
  }

  @override
  Future<String> export({required bool includeAttachments, required String appVersion}) async {
    final snapshot = await _exportableSnapshot(includeAttachments: includeAttachments);
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
  Future<BackupStats> restore(String path, BackupImportMode mode) async {
    final backup = (await _read(path)).snapshot;

    return switch (mode) {
      BackupImportMode.replace => _replace(path, backup),
      BackupImportMode.merge => _merge(path, backupAdditions(backup: backup, local: await _localSnapshot())),
    };
  }

  @override
  Future<void> deleteAll() async {
    await _db.transaction(_deleteRows);
    await _deleteIfExists(await _attachments.rootDirectory());
  }

  Future<BackupStats> _replace(String path, BackupSnapshot backup) async {
    final root = await _attachments.rootDirectory();
    final staging = await _freshStaging(root);
    final retired = Directory('${root.path}$_retiredSuffix');
    final BackupSnapshot restored;

    await _deleteIfExists(retired);

    try {
      restored = backup.withAttachments(await _extract(path, staging.path, backup.attachments));
      await _db.transaction(() async {
        await _deleteRows();
        await _insertRows(restored);
      });
    } on Object {
      await _deleteIfExists(staging);
      rethrow;
    }

    if (await root.exists()) {
      await root.rename(retired.path);
    }

    await staging.rename(root.path);
    await _deleteIfExists(retired);

    return BackupStats.of(restored);
  }

  Future<BackupStats> _merge(String path, BackupSnapshot additions) async {
    final root = await _attachments.rootDirectory();
    final staging = await _freshStaging(root);
    final moved = <File>[];

    try {
      final extracted = await _extract(path, staging.path, additions.attachments);
      final merged = additions.withAttachments(extracted);

      for (final attachment in extracted) {
        final target = File(p.join(root.path, attachment.path));

        await target.parent.create(recursive: true);
        moved.add(await File(p.join(staging.path, attachment.path)).rename(target.path));
      }

      await _db.transaction(() => _insertRows(merged));

      return BackupStats.of(merged);
    } on Object {
      for (final file in moved) {
        if (await file.exists()) {
          await file.delete();
        }
      }

      rethrow;
    } finally {
      await _deleteIfExists(staging);
    }
  }

  Future<Directory> _freshStaging(Directory root) async {
    final staging = Directory('${root.path}$_stagingSuffix');

    await _deleteIfExists(staging);

    return staging.create(recursive: true);
  }

  Future<void> _deleteRows() async {
    await _db.delete(_db.attachments).go();
    await _db.delete(_db.shifts).go();
    await _db.delete(_db.events).go();
    await _db.delete(_db.shiftTemplates).go();
  }

  Future<void> _insertRows(BackupSnapshot snapshot) {
    return _db.batch((batch) {
      batch.insertAll(_db.shiftTemplates, snapshot.templates.map(templateToCompanion));
      batch.insertAll(_db.shifts, snapshot.shifts.map(shiftToCompanion));
      batch.insertAll(_db.events, snapshot.events.map(eventToCompanion));
      batch.insertAll(_db.attachments, snapshot.attachments.map(attachmentToCompanion));
    });
  }

  Future<BackupSnapshot> _localSnapshot() async {
    return BackupSnapshot(
      templates: (await _db.select(_db.shiftTemplates).get()).map(templateFromRow).toList(),
      shifts: (await _db.select(_db.shifts).get()).map(shiftFromRow).toList(),
      events: (await _db.select(_db.events).get()).map(eventFromRow).toList(),
      attachments: (await _db.select(_db.attachments).get()).map(attachmentFromRow).toList(),
    );
  }

  Future<BackupSnapshot> _exportableSnapshot({required bool includeAttachments}) async {
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

  static Future<List<Attachment>> _extract(String path, String attachmentsRoot, List<Attachment> attachments) {
    return Isolate.run(() => extractBackupAttachments(path, attachmentsRoot, attachments));
  }

  static Future<void> _deleteIfExists(Directory directory) async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}
