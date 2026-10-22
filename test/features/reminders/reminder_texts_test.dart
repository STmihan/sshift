import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sshift/domain/models/app_settings.dart';
import 'package:sshift/domain/models/time_format.dart';
import 'package:sshift/features/reminders/pending_reminder.dart';
import 'package:sshift/features/reminders/reminder_texts.dart';

PendingReminder _reminder({required DateTime at, required DateTime day}) {
  return PendingReminder(at: at, day: day, title: 'Day', allDay: false, startMinute: 600, endMinute: 1260);
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  final texts = ReminderTexts.fromSettings(const AppSettings(languageCode: 'en', timeFormat: TimeFormat.hours24));

  test('day is relative to the moment the reminder fires', () {
    expect(
      texts.body(_reminder(at: DateTime(2026, 10, 21, 10), day: DateTime(2026, 10, 22))),
      'Tomorrow, 10:00 - 21:00',
    );
    expect(
      texts.body(_reminder(at: DateTime(2026, 10, 22, 9, 30), day: DateTime(2026, 10, 22))),
      'Today, 10:00 - 21:00',
    );
  });
}
