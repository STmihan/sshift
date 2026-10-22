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
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.attachments);
        await m.createIndex(schema.attachmentsShift);
      },
      from2To3: (m, schema) async {
        await customStatement('DROP INDEX IF EXISTS attachments_shift');
        await m.alterTable(
          TableMigration(
            schema.attachments,
            columnTransformer: {
              schema.attachments.ownerType: const Constant('shift'),
              schema.attachments.ownerId: const CustomExpression<String>('shift_id'),
            },
            newColumns: [schema.attachments.ownerType, schema.attachments.ownerId],
          ),
        );
        await m.createIndex(schema.attachmentsOwner);
      },
      from3To4: (m, schema) async {
        await m.addColumn(schema.shiftTemplates, schema.shiftTemplates.reminderOffset);
        await m.addColumn(schema.shifts, schema.shifts.reminderOffset);
        await m.addColumn(schema.events, schema.events.reminderOffset);
      },
    ),
  );
}
