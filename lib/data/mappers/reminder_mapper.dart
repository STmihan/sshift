import '../../domain/models/reminder.dart';

Reminder? reminderFromColumn(int? offset) {
  return offset == null ? null : Reminder(offset);
}
