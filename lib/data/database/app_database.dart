import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/attachments_table.dart';
import 'tables/events_table.dart';
import 'tables/shift_templates_table.dart';
import 'tables/shifts_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ShiftTemplates, Shifts, Events, Attachments])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'sshift'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement('CREATE INDEX shifts_day ON shifts (day)');
      await customStatement('CREATE INDEX shifts_template ON shifts (template_id, day)');
      await customStatement('CREATE INDEX events_day ON events (day)');
      await _createAttachmentsIndex();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(attachments);
        await _createAttachmentsIndex();
      }
    },
  );

  Future<void> _createAttachmentsIndex() {
    return customStatement('CREATE INDEX attachments_shift ON attachments (shift_id)');
  }
}
