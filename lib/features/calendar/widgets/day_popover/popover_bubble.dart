import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/shift_colors.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/dates.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/shift_avatar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../entries/event_draft.dart';
import '../../../entries/event_sheet.dart';
import '../../../entries/shift_sheet.dart';
import '../../../schedule/schedule_actions.dart';
import '../../../schedule/schedule_providers.dart';
import '../../../templates/templates_providers.dart';
import '../../../templates/widgets/template_picker_sheet.dart';
import 'popover_add_button.dart';
import 'popover_entry_row.dart';

class PopoverBubble extends ConsumerWidget {
  const PopoverBubble({required this.day, super.key});

  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final entries = ref.watch(dayEntriesProvider(dayKey(day)));
    final templates = ref.watch(templatesByIdProvider);
    final divider = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Divider(height: 1, thickness: 1, color: p.onPopover.withValues(alpha: 0.12)),
    );

    final rows = <Widget>[
      for (final s in entries.shifts)
        PopoverEntryRow(
          leading: ShiftAvatar(
            icon: templates[s.templateId]?.icon ?? '',
            color: templates[s.templateId]?.color ?? fallbackShiftColor,
            size: 26,
          ),
          title: templates[s.templateId]?.title ?? l.shift,
          subtitle: formatSpan(context, s),
          trailing: formatDuration(context, s.workedMinutes),
          onTap: () => showShiftSheet(context, s),
        ),
      for (final e in entries.events)
        PopoverEntryRow(
          leading: SizedBox(
            width: 26,
            child: Center(child: CircleAvatar(radius: 4, backgroundColor: p.event)),
          ),
          title: e.title,
          subtitle: formatSpan(context, e),
          trailing: formatDuration(context, e.spanMinutes),
          onTap: () => showEventSheet(context, e),
        ),
    ];

    return Material(
      color: p.popover,
      elevation: 12,
      shadowColor: p.shadow.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (rows.isNotEmpty) ...[
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  children: [
                    for (var i = 0; i < rows.length; i++) ...[if (i > 0) divider, rows[i]],
                  ],
                ),
              ),
            ),
            divider,
          ],
          SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: PopoverAddButton(
                    label: l.shift,
                    onTap: () async {
                      final template = await pickTemplate(context);

                      if (template != null) {
                        await ref.read(scheduleActionsProvider).addShift(template, day);
                      }
                    },
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  indent: 12,
                  endIndent: 12,
                  color: p.onPopover.withValues(alpha: 0.15),
                ),
                Expanded(
                  child: PopoverAddButton(
                    label: l.event,
                    onTap: () => showEventSheet(context, draftEvent(day), isNew: true),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
