import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/id.dart';
import '../../domain/models/attachment.dart';
import '../../domain/models/attachment_owner.dart';
import '../../domain/models/attachment_owner_type.dart';
import '../../domain/repositories/attachments_repository.dart';
import '../attachments/attachment_paths.dart';
import '../database/app_database.dart';
import '../mappers/attachment_row_mapper.dart';

class DriftAttachmentsRepository implements AttachmentsRepository {
  DriftAttachmentsRepository(this._db, {Future<Directory> Function()? root}) : _root = root ?? _defaultRoot;

  final AppDatabase _db;
  final Future<Directory> Function() _root;

  static Future<Directory> _defaultRoot() async {
    return Directory(p.join((await getApplicationDocumentsDirectory()).path, 'attachments'));
  }

  @override
  Stream<List<Attachment>> watchFor(AttachmentOwner owner) {
    final query = _db.select(_db.attachments)
      ..where((a) => a.ownerType.equals(owner.type.name) & a.ownerId.equals(owner.id))
      ..orderBy([(a) => OrderingTerm(expression: a.createdAt)]);

    return query.watch().map((rows) => rows.map(attachmentFromRow).toList());
  }

  @override
  Future<Attachment> add(AttachmentOwner owner, XFile file) async {
    final count = _db.attachments.id.count();
    final existing =
        await (_db.selectOnly(_db.attachments)
              ..addColumns([count])
              ..where(_db.attachments.ownerType.equals(owner.type.name) & _db.attachments.ownerId.equals(owner.id)))
            .map((row) => row.read(count)!)
            .getSingle();

    if (existing >= Attachment.maxPerOwner) {
      throw StateError('Attachment limit (${Attachment.maxPerOwner}) reached');
    }

    final id = newId();
    final name = file.name.isEmpty ? p.basename(file.path) : file.name;
    final relative = attachmentRelativePath(owner.id, id, name);
    final target = File(p.join((await _root()).path, relative));

    await target.parent.create(recursive: true);
    await file.saveTo(target.path);

    final attachment = Attachment(
      id: id,
      owner: owner,
      name: name,
      path: relative,
      size: await target.length(),
      createdAt: DateTime.now(),
    );

    await _db.into(_db.attachments).insert(attachmentToCompanion(attachment));

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
  Future<void> deleteForOwner(AttachmentOwner owner) {
    return deleteForOwners(owner.type, [owner.id]);
  }

  @override
  Future<void> deleteOrphans({required DateTime createdBefore}) async {
    final shiftIds = _db.selectOnly(_db.shifts)..addColumns([_db.shifts.id]);
    final eventIds = _db.selectOnly(_db.events)..addColumns([_db.events.id]);
    final orphans =
        await (_db.select(_db.attachments)..where(
              (a) =>
                  a.createdAt.isSmallerThanValue(createdBefore) &
                  ((a.ownerType.equals(AttachmentOwnerType.shift.name) & a.ownerId.isNotInQuery(shiftIds)) |
                      (a.ownerType.equals(AttachmentOwnerType.event.name) & a.ownerId.isNotInQuery(eventIds))),
            ))
            .get();
    final owners = {for (final row in orphans) attachmentOwnerFromRow(row)};

    for (final owner in owners) {
      await deleteForOwner(owner);
    }
  }

  @override
  Future<String> resolvePath(Attachment attachment) async {
    return p.join((await _root()).path, attachment.path);
  }

  Future<Directory> rootDirectory() {
    return _root();
  }

  Future<void> deleteForOwners(AttachmentOwnerType type, List<String> ownerIds) async {
    if (ownerIds.isEmpty) {
      return;
    }

    await (_db.delete(_db.attachments)..where((a) => a.ownerType.equals(type.name) & a.ownerId.isIn(ownerIds))).go();
    final root = await _root();

    for (final id in ownerIds) {
      final dir = Directory(p.join(root.path, id));

      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    }
  }
}
