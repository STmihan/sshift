import 'package:drift/drift.dart';

@DataClassName('ShiftRow')
@TableIndex(name: 'shifts_day', columns: {#day})
@TableIndex(name: 'shifts_template', columns: {#templateId, #day})
class Shifts extends Table {
  TextColumn get id => text()();
  TextColumn get templateId => text()();
  IntColumn get day => integer()();
  BoolColumn get allDay => boolean()();
  IntColumn get startMinute => integer()();
  IntColumn get endMinute => integer()();
  IntColumn get breakMinutes => integer()();
  TextColumn get notes => text()();
  TextColumn get location => text()();
  IntColumn get payType => integer()();
  IntColumn get payAmount => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get reminderOffset => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
