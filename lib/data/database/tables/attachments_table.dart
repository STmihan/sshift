import 'package:drift/drift.dart';

@DataClassName('AttachmentRow')
class Attachments extends Table {
  TextColumn get id => text()();
  TextColumn get shiftId => text()();
  TextColumn get name => text()();
  TextColumn get path => text()();
  IntColumn get size => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
