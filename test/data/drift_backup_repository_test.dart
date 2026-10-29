import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:cross_file/cross_file.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sshift/data/database/app_database.dart';
import 'package:sshift/data/repositories/drift_attachments_repository.dart';
import 'package:sshift/data/repositories/drift_backup_repository.dart';
import 'package:sshift/data/repositories/drift_schedule_repository.dart';
import 'package:sshift/data/repositories/drift_templates_repository.dart';
import 'package:sshift/domain/models/attachment_owner.dart';
import 'package:sshift/domain/models/backup_format_exception.dart';
import 'package:sshift/domain/models/backup_rejection.dart';
import 'package:sshift/domain/models/calendar_event.dart';
import 'package:sshift/domain/models/pay.dart';
import 'package:sshift/domain/models/pay_type.dart';
import 'package:sshift/domain/models/reminder.dart';
import 'package:sshift/domain/models/shift.dart';
import 'package:sshift/domain/models/shift_template.dart';

const _appVersion = '1.4.0';

ShiftTemplate _template(String id) {
  return ShiftTemplate(
    id: id,
    title: 'Day $id',
    icon: 'D',
    color: 0xFF4CAF50,
    startMinute: 8 * 60,
    endMinute: 18 * 60,
    breakMinutes: 60,
    defaultPay: const Pay(PayType.hourly, 50000),
    location: 'Office',
    sortOrder: 1,
    reminder: const Reminder.beforeStart(30),
    updatedAt: DateTime(2026, 10, 20, 8),
  );
}

Shift _shift(String id, String templateId) {
  return Shift(
    id: id,
    templateId: templateId,
    day: DateTime(2026, 10, 29),
    allDay: false,
    startMinute: 9 * 60,
    endMinute: 18 * 60,
    breakMinutes: 60,
    notes: 'Notes',
    pay: const Pay(PayType.fixed, 300000),
    updatedAt: DateTime(2026, 10, 21, 9, 30),
  );
}

CalendarEvent _event(String id) {
  return CalendarEvent(
    id: id,
    day: DateTime(2026, 11, 2),
    title: 'Doctor',
    allDay: true,
    startMinute: 0,
    endMinute: 0,
    reminder: const Reminder.onDay(daysBefore: 1, minuteOfDay: 9 * 60),
    updatedAt: DateTime(2026, 10, 22, 12),
  );
}

void main() {
  late AppDatabase db;
  late Directory sandbox;
  late Directory root;
  late DriftAttachmentsRepository attachments;
  late DriftTemplatesRepository templates;
  late DriftScheduleRepository schedule;
  late DriftBackupRepository backup;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    sandbox = await Directory.systemTemp.createTemp('backup_test');
    root = Directory(p.join(sandbox.path, 'attachments'));
    attachments = DriftAttachmentsRepository(db, root: () async => root);
    templates = DriftTemplatesRepository(db, attachments);
    schedule = DriftScheduleRepository(db, attachments);
    backup = DriftBackupRepository(db, attachments, () async => Directory(p.join(sandbox.path, 'work')));
  });

  tearDown(() async {
    await db.close();
    await sandbox.delete(recursive: true);
  });

  Future<XFile> source(String name, List<int> bytes) async {
    final file = File(p.join(sandbox.path, 'sources', '${bytes.hashCode}.bin'));

    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);

    return XFile(file.path, name: name);
  }

  Future<Map<String, List<Map<String, dynamic>>>> dump() async {
    return {
      'templates': [for (final row in await db.select(db.shiftTemplates).get()) row.toJson()],
      'shifts': [for (final row in await db.select(db.shifts).get()) row.toJson()],
      'events': [for (final row in await db.select(db.events).get()) row.toJson()],
      'attachments': [for (final row in await db.select(db.attachments).get()) row.toJson()],
    };
  }

  Future<void> seed() async {
    await templates.upsert(_template('t1'));
    await schedule.upsertShift(_shift('s1', 't1'));
    await schedule.upsertEvent(_event('e1'));
    await attachments.add(const AttachmentOwner.shift('s1'), await source('photo.jpg', [1, 2, 3, 4]));
    await attachments.add(const AttachmentOwner.event('e1'), await source('ticket: 1.pdf', [5, 6]));
  }

  Future<String> archive(Map<String, Object?> json, {Map<String, List<int>> files = const {}}) async {
    final target = p.join(sandbox.path, 'crafted.sshift');
    final encoder = ZipFileEncoder()..create(target);

    encoder.addArchiveFile(ArchiveFile.string('backup.json', jsonEncode(json)));

    for (final MapEntry(:key, :value) in files.entries) {
      encoder.addArchiveFile(ArchiveFile.bytes(key, value));
    }

    encoder.closeSync();

    return target;
  }

  Map<String, Object?> header({int formatVersion = 1}) {
    return {
      'format': 'sshift-backup',
      'formatVersion': formatVersion,
      'appVersion': _appVersion,
      'exportedAt': '2026-10-29T10:00:00.000Z',
      'templates': <Object?>[],
      'shifts': <Object?>[],
      'events': <Object?>[],
    };
  }

  Future<BackupRejection> rejection(Future<void> Function() action) async {
    try {
      await action();
    } on BackupFormatException catch (error) {
      return error.reason;
    }

    fail('Expected BackupFormatException');
  }

  test('export and restore bring back rows and attachment files', () async {
    await seed();
    final original = await dump();
    final path = await backup.export(includeAttachments: true, appVersion: _appVersion);

    expect(p.extension(path), '.sshift');

    await templates.delete('t1');
    await schedule.upsertEvent(_event('e2'));
    await backup.restore(path);

    expect(await dump(), original);

    for (final row in await db.select(db.attachments).get()) {
      expect(await File(p.join(root.path, row.path)).length(), row.size);
    }

    expect(await File(p.join(root.path, original['attachments']!.first['path'] as String)).readAsBytes(), [
      1,
      2,
      3,
      4,
    ]);
    expect(await Directory('${root.path}_import').exists(), isFalse);
    expect(await Directory('${root.path}_old').exists(), isFalse);
  });

  test('inspect reports what the backup contains', () async {
    await seed();
    final path = await backup.export(includeAttachments: true, appVersion: _appVersion);
    final info = await backup.inspect(path);

    expect(info.appVersion, _appVersion);
    expect(info.stats.templates, 1);
    expect(info.stats.shifts, 1);
    expect(info.stats.events, 1);
    expect(info.stats.attachments, 2);
    expect(info.stats.attachmentBytes, 6);
  });

  test('export without attachments restores no files', () async {
    await seed();
    final path = await backup.export(includeAttachments: false, appVersion: _appVersion);

    await backup.restore(path);

    expect(await db.select(db.shifts).get(), hasLength(1));
    expect(await db.select(db.attachments).get(), isEmpty);
    expect(await root.list().toList(), isEmpty);
  });

  test('attachments of unsaved drafts are not exported', () async {
    await seed();
    await attachments.add(const AttachmentOwner.event('draft'), await source('draft.jpg', [9]));

    final stats = await backup.currentStats();

    expect(stats.attachments, 2);
  });

  test('a file that is not a zip is unrecognized and changes nothing', () async {
    await seed();
    final before = await dump();
    final file = File(p.join(sandbox.path, 'random.sshift'));

    await file.writeAsString('hello');

    expect(await rejection(() => backup.inspect(file.path)), BackupRejection.unrecognized);
    expect(await rejection(() => backup.restore(file.path)), BackupRejection.unrecognized);
    expect(await dump(), before);
  });

  test('a newer format version is rejected', () async {
    final path = await archive(header(formatVersion: 2));

    expect(await rejection(() => backup.inspect(path)), BackupRejection.newerVersion);
  });

  test('a shift pointing to a missing template is rejected without touching data', () async {
    await seed();
    final before = await dump();
    final beforeFiles = await root.list(recursive: true).map((e) => e.path).toList();
    final json = header()
      ..['shifts'] = [
        {
          'id': 's9',
          'templateId': 'missing',
          'day': '2026-10-29',
          'allDay': false,
          'startMinute': 0,
          'endMinute': 60,
          'breakMinutes': 0,
          'notes': '',
          'location': '',
          'pay': {'type': 'none', 'amount': 0},
          'reminderOffset': null,
          'updatedAt': '2026-10-29T10:00:00.000Z',
        },
      ];
    final path = await archive(json);

    expect(await rejection(() => backup.restore(path)), BackupRejection.corrupted);
    expect(await dump(), before);
    expect(await root.list(recursive: true).map((e) => e.path).toList(), unorderedEquals(beforeFiles));
    expect(await Directory('${root.path}_import').exists(), isFalse);
  });

  test('an attachment without its file in the archive is rejected', () async {
    final path = await archive(
      header()
        ..['events'] = [
          {
            'id': 'e1',
            'day': '2026-11-02',
            'title': 'Doctor',
            'allDay': true,
            'startMinute': 0,
            'endMinute': 0,
            'notes': '',
            'location': '',
            'pay': {'type': 'none', 'amount': 0},
            'reminderOffset': null,
            'updatedAt': '2026-10-29T10:00:00.000Z',
          },
        ]
        ..['attachments'] = [
          {
            'id': 'a1',
            'ownerType': 'event',
            'ownerId': 'e1',
            'name': 'x.jpg',
            'size': 1,
            'createdAt': '2026-10-29T10:00:00.000Z',
          },
        ],
    );

    expect(await rejection(() => backup.inspect(path)), BackupRejection.corrupted);
  });

  test('ids that could escape the attachments folder are rejected', () async {
    final path = await archive(
      header()
        ..['templates'] = [
          {
            'id': '../evil',
            'title': 'x',
            'icon': 'x',
            'color': 0,
            'allDay': false,
            'startMinute': 0,
            'endMinute': 60,
            'breakMinutes': 0,
            'pay': {'type': 'none', 'amount': 0},
            'location': '',
            'sortOrder': 0,
            'reminderOffset': null,
            'updatedAt': '2026-10-29T10:00:00.000Z',
          },
        ],
    );

    expect(await rejection(() => backup.inspect(path)), BackupRejection.corrupted);
  });
}
