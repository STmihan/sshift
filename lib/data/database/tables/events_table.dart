import 'package:drift/drift.dart';

@DataClassName('EventRow')
@TableIndex(name: 'events_day', columns: {#day})
class Events extends Table {
  TextColumn get id => text()();
  IntColumn get day => integer()();
  TextColumn get title => text()();
  BoolColumn get allDay => boolean()();
  IntColumn get startMinute => integer()();
  IntColumn get endMinute => integer()();
  TextColumn get notes => text()();
  TextColumn get location => text()();
  IntColumn get payType => integer()();
  IntColumn get payAmount => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get reminderOffset => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
