import 'package:drift/drift.dart' hide isNull;
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/data/database/app_database.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;
import 'generated/schema_v4.dart' as v4;

const _updatedAt = 1792000000;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('schema migrations', () {
    const versions = GeneratedHelper.versions;

    for (final (i, fromVersion) in versions.indexed) {
      for (final toVersion in versions.skip(i + 1)) {
        test('from $fromVersion to $toVersion', () async {
          final schema = await verifier.schemaAt(fromVersion);
          final db = AppDatabase(schema.newConnection());

          await verifier.migrateAndValidate(db, toVersion);
          await db.close();
        });
      }
    }
  });

  test('migration from v1 to v2 keeps existing data', () async {
    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch
          ..insert(
            oldDb.shiftTemplates,
            const v1.ShiftTemplatesData(
              id: 't1',
              title: 'Day',
              icon: 'D',
              color: 0xFFB0416E,
              allDay: 0,
              startMinute: 600,
              endMinute: 1260,
              breakMinutes: 30,
              payType: 1,
              payAmount: 350000,
              location: 'Office',
              sortOrder: 0,
              updatedAt: _updatedAt,
            ),
          )
          ..insert(
            oldDb.shifts,
            const v1.ShiftsData(
              id: 's1',
              templateId: 't1',
              day: 20261022,
              allDay: 0,
              startMinute: 600,
              endMinute: 1260,
              breakMinutes: 30,
              notes: 'Notes',
              location: 'Office',
              payType: 1,
              payAmount: 350000,
              updatedAt: _updatedAt,
            ),
          )
          ..insert(
            oldDb.events,
            const v1.EventsData(
              id: 'e1',
              day: 20261022,
              title: 'Meeting',
              allDay: 0,
              startMinute: 900,
              endMinute: 960,
              notes: '',
              location: '',
              payType: 0,
              payAmount: 0,
              updatedAt: _updatedAt,
            ),
          );
      },
      validateItems: (newDb) async {
        final templates = await newDb.select(newDb.shiftTemplates).get();
        final shifts = await newDb.select(newDb.shifts).get();
        final events = await newDb.select(newDb.events).get();

        expect(templates.single, isA<v2.ShiftTemplatesData>().having((t) => t.payAmount, 'payAmount', 350000));
        expect(shifts.single, isA<v2.ShiftsData>().having((s) => s.notes, 'notes', 'Notes'));
        expect(events.single, isA<v2.EventsData>().having((e) => e.title, 'title', 'Meeting'));
        expect(await newDb.select(newDb.attachments).get(), isEmpty);
      },
    );
  });

  test('migration from v2 to v3 turns shift attachments into owned attachments', () async {
    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(
          oldDb.attachments,
          const v2.AttachmentsData(
            id: 'a1',
            shiftId: 's1',
            name: 'photo.jpg',
            path: 's1/a1_photo.jpg',
            size: 1024,
            createdAt: _updatedAt,
          ),
        );
      },
      validateItems: (newDb) async {
        final attachments = await newDb.select(newDb.attachments).get();

        expect(
          attachments,
          [
            const v3.AttachmentsData(
              id: 'a1',
              ownerType: 'shift',
              ownerId: 's1',
              name: 'photo.jpg',
              path: 's1/a1_photo.jpg',
              size: 1024,
              createdAt: _updatedAt,
            ),
          ],
        );
      },
    );
  });

  test('migration from v3 to v4 adds empty reminders', () async {
    await verifier.testWithDataIntegrity(
      oldVersion: 3,
      newVersion: 4,
      createOld: v3.DatabaseAtV3.new,
      createNew: v4.DatabaseAtV4.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(
          oldDb.shifts,
          const v3.ShiftsData(
            id: 's1',
            templateId: 't1',
            day: 20261022,
            allDay: 0,
            startMinute: 600,
            endMinute: 1260,
            breakMinutes: 0,
            notes: '',
            location: '',
            payType: 0,
            payAmount: 0,
            updatedAt: _updatedAt,
          ),
        );
      },
      validateItems: (newDb) async {
        final shifts = await newDb.select(newDb.shifts).get();

        expect(shifts.single.id, 's1');
        expect(shifts.single.reminderOffset, isNull);
      },
    );
  });
}
