import '../../domain/models/reminder.dart';
import '../../domain/models/time_span.dart';
import '../../l10n/app_localizations.dart';

String reminderLabel(AppLocalizations l, Reminder? reminder, {required bool allDay}) {
  if (reminder == null) {
    return l.none;
  }

  if (allDay) {
    return reminder.daysBefore == 0 ? l.reminderOnDay : l.reminderAllDayDayBefore;
  }

  final minutes = reminder.minutesBeforeStart;

  if (minutes == 0) {
    return l.reminderAtStart;
  }

  if (minutes >= minutesPerDay && minutes % minutesPerDay == 0) {
    return l.reminderDayBefore;
  }

  if (minutes % 60 == 0) {
    return l.reminderHoursBefore(minutes ~/ 60);
  }

  return l.reminderMinutesBefore(minutes);
}
