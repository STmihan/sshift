import 'package:drift/drift.dart';

@DataClassName('TemplateRow')
class ShiftTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get icon => text()();
  IntColumn get color => integer()();
  BoolColumn get allDay => boolean()();
  IntColumn get startMinute => integer()();
  IntColumn get endMinute => integer()();
  IntColumn get breakMinutes => integer()();
  IntColumn get payType => integer()();
  IntColumn get payAmount => integer()();
  TextColumn get location => text()();
  IntColumn get sortOrder => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get reminderOffset => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
