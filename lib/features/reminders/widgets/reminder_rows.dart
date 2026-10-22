import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/field_row.dart';
import '../../../core/widgets/option_picker_sheet.dart';
import '../../../core/widgets/time_picker/pick_time.dart';
import '../../../domain/models/reminder.dart';
import '../../../l10n/app_localizations.dart';
import '../reminder_label.dart';

typedef ReminderChoice = ({Reminder? value});

List<Widget> reminderRows({
  required BuildContext context,
  required Reminder? reminder,
  required bool allDay,
  required ValueChanged<Reminder?> onChanged,
}) {
  final l = AppLocalizations.of(context);
  final allDayMinute = reminder?.minuteOfDay ?? Reminder.defaultAllDayMinute;
  final options = <ReminderChoice>[
    (value: null),
    if (allDay)
      for (final days in Reminder.allDayDaysBefore) (value: Reminder.onDay(daysBefore: days, minuteOfDay: allDayMinute))
    else
      for (final minutes in Reminder.presetsBeforeStart) (value: Reminder.beforeStart(minutes)),
  ];

  return [
    FieldRow(
      label: l.reminder,
      value: reminderLabel(l, reminder, allDay: allDay),
      onTap: () async {
        final choice = await showOptionPicker<ReminderChoice>(
          context,
          title: l.reminder,
          options: options,
          selected: (value: reminder),
          label: (option) => reminderLabel(l, option.value, allDay: allDay),
        );

        if (choice != null) {
          onChanged(choice.value);
        }
      },
    ),
    if (allDay && reminder != null)
      FieldRow(
        label: l.reminderTime,
        value: formatTime(context, reminder.minuteOfDay),
        onTap: () async {
          final minute = await pickTime(context, title: l.reminderTime, minute: reminder.minuteOfDay);

          if (minute != null) {
            onChanged(Reminder.onDay(daysBefore: reminder.daysBefore, minuteOfDay: minute));
          }
        },
      ),
  ];
}
