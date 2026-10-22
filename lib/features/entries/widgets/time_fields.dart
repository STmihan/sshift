import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/field_row.dart';
import '../../../core/widgets/group_card.dart';
import '../../../core/widgets/option_picker_sheet.dart';
import '../../../core/widgets/switch_row.dart';
import '../../../core/widgets/time_picker/pick_time.dart';
import '../../../domain/models/reminder.dart';
import '../../../l10n/app_localizations.dart';
import '../../reminders/widgets/reminder_rows.dart';

class TimeFields extends StatelessWidget {
  const TimeFields({
    required this.allDay,
    required this.startMinute,
    required this.endMinute,
    required this.onAllDay,
    required this.onStart,
    required this.onEnd,
    this.breakMinutes,
    this.onBreak,
    this.reminder,
    this.onReminder,
    this.leading = const [],
    super.key,
  });

  static const breakOptions = [0, 15, 20, 30, 45, 60, 90, 120];

  final bool allDay;
  final int startMinute;
  final int endMinute;
  final int? breakMinutes;
  final ValueChanged<bool> onAllDay;
  final ValueChanged<int> onStart;
  final ValueChanged<int> onEnd;
  final ValueChanged<int>? onBreak;
  final Reminder? reminder;
  final ValueChanged<Reminder?>? onReminder;
  final List<Widget> leading;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final endsNextDay = !allDay && endMinute <= startMinute;
    final breakValue = breakMinutes;
    final breakChanged = onBreak;
    final reminderChanged = onReminder;

    String breakLabel(int minutes) {
      return minutes == 0 ? l.none : formatDuration(context, minutes);
    }

    return GroupCard(
      children: [
        ...leading,
        SwitchRow(label: l.allDay, value: allDay, onChanged: onAllDay),
        if (!allDay) ...[
          FieldRow(
            label: l.start,
            value: formatTime(context, startMinute),
            onTap: () async {
              final minute = await pickTime(context, title: l.start, minute: startMinute);

              if (minute != null) {
                onStart(minute);
              }
            },
          ),
          FieldRow(
            label: l.end,
            value: formatTime(context, endMinute),
            trailing: endsNextDay
                ? Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(l.nextDay, style: TextStyle(fontSize: 12, color: p.textSecondary)),
                  )
                : null,
            onTap: () async {
              final minute = await pickTime(context, title: l.end, minute: endMinute);

              if (minute != null) {
                onEnd(minute);
              }
            },
          ),
        ],
        if (breakValue != null && breakChanged != null)
          FieldRow(
            label: l.breakLabel,
            value: breakLabel(breakValue),
            onTap: () async {
              final minutes = await showOptionPicker<int>(
                context,
                title: l.breakLabel,
                options: breakOptions,
                selected: breakValue,
                label: breakLabel,
              );

              if (minutes != null) {
                breakChanged(minutes);
              }
            },
          ),
        if (reminderChanged != null)
          ...reminderRows(context: context, reminder: reminder, allDay: allDay, onChanged: reminderChanged),
      ],
    );
  }
}
