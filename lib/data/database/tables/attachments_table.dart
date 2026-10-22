import 'package:drift/drift.dart';

@DataClassName('AttachmentRow')
@TableIndex(name: 'attachments_owner', columns: {#ownerType, #ownerId})
class Attachments extends Table {
  TextColumn get id => text()();
  TextColumn get ownerType => text()();
  TextColumn get ownerId => text()();
  TextColumn get name => text()();
  TextColumn get path => text()();
  IntColumn get size => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
