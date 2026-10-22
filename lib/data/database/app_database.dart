import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'app_database.steps.dart';
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
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.attachments);
        await m.createIndex(schema.attachmentsShift);
      },
    ),
  );
}
