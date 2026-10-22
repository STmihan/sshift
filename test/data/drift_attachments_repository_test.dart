import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sshift/data/database/app_database.dart';
import 'package:sshift/data/repositories/drift_attachments_repository.dart';
import 'package:sshift/data/repositories/drift_schedule_repository.dart';
import 'package:sshift/domain/models/attachment_owner.dart';
import 'package:sshift/domain/models/calendar_event.dart';

CalendarEvent _event(String id) {
  return CalendarEvent(
    id: id,
    day: DateTime(2026, 10, 22),
    title: 'Event',
    startMinute: 600,
    endMinute: 660,
    updatedAt: DateTime(2026, 10, 22),
  );
}

void main() {
  late AppDatabase db;
  late Directory root;
  late Directory sources;
  late DriftAttachmentsRepository attachments;
  late DriftScheduleRepository schedule;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    root = await Directory.systemTemp.createTemp('attachments');
    sources = await Directory.systemTemp.createTemp('sources');
    attachments = DriftAttachmentsRepository(db, root: () async => root);
    schedule = DriftScheduleRepository(db, attachments);
  });

  tearDown(() async {
    await db.close();
    await root.delete(recursive: true);
    await sources.delete(recursive: true);
  });

  Future<XFile> source(String name) async {
    final file = File(p.join(sources.path, name));

    await file.writeAsBytes([1, 2, 3]);

    return XFile(file.path, name: name);
  }

  test('event attachments are stored per owner and removed with the event', () async {
    const owner = AttachmentOwner.event('e1');

    await schedule.upsertEvent(_event('e1'));
    final attachment = await attachments.add(owner, await source('ticket.pdf'));

    expect(await attachments.watchFor(owner).first, hasLength(1));
    expect(await attachments.watchFor(const AttachmentOwner.shift('e1')).first, isEmpty);
    expect(await File(await attachments.resolvePath(attachment)).exists(), isTrue);

    await schedule.deleteEvent('e1');

    expect(await attachments.watchFor(owner).first, isEmpty);
    expect(await Directory(p.join(root.path, 'e1')).exists(), isFalse);
  });

  test('deleteOrphans removes attachments of unsaved drafts only', () async {
    await schedule.upsertEvent(_event('saved'));
    await attachments.add(const AttachmentOwner.event('saved'), await source('a.jpg'));
    await attachments.add(const AttachmentOwner.event('draft'), await source('b.jpg'));

    await attachments.deleteOrphans(createdBefore: DateTime.now().add(const Duration(minutes: 1)));

    expect(await attachments.watchFor(const AttachmentOwner.event('saved')).first, hasLength(1));
    expect(await attachments.watchFor(const AttachmentOwner.event('draft')).first, isEmpty);
    expect(await Directory(p.join(root.path, 'draft')).exists(), isFalse);
  });

  test('deleteOrphans keeps attachments created after the cutoff', () async {
    await attachments.add(const AttachmentOwner.event('draft'), await source('c.jpg'));

    await attachments.deleteOrphans(createdBefore: DateTime.now().subtract(const Duration(minutes: 1)));

    expect(await attachments.watchFor(const AttachmentOwner.event('draft')).first, hasLength(1));
  });
}
