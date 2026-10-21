import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logger.dart';
import '../../core/theme/shift_colors.dart';
import '../../core/theme/theme_context.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_sheet.dart';
import '../../core/widgets/shift_avatar.dart';
import '../../data/data_providers.dart';
import '../../domain/models/pay.dart';
import '../../domain/models/shift.dart';
import '../../l10n/app_localizations.dart';
import '../settings/settings_controller.dart';
import '../templates/templates_providers.dart';
import 'widgets/attachments/attachments_section.dart';
import 'widgets/entry_sheet_header.dart';
import 'widgets/entry_sheet_layout.dart';
import 'widgets/notes_card.dart';
import 'widgets/pay/pay_editor.dart';
import 'widgets/pay_section_label.dart';
import 'widgets/time_fields.dart';

Future<void> showShiftSheet(BuildContext context, Shift shift) {
  return showAppSheet<void>(context, (_) => ShiftSheet(shift: shift));
}

class ShiftSheet extends ConsumerStatefulWidget {
  const ShiftSheet({required this.shift, super.key});

  final Shift shift;

  @override
  ConsumerState<ShiftSheet> createState() {
    return _ShiftSheetState();
  }
}

class _ShiftSheetState extends ConsumerState<ShiftSheet> {
  late Shift _draft = widget.shift;
  late final _notes = TextEditingController(text: widget.shift.notes);
  late final _location = TextEditingController(text: widget.shift.location);
  List<Pay> _suggestions = const [];

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  @override
  void dispose() {
    _notes.dispose();
    _location.dispose();
    super.dispose();
  }

  Future<void> _loadSuggestions() async {
    final pays = await ref.read(scheduleRepositoryProvider).recentShiftPays(widget.shift.templateId);

    if (mounted) {
      setState(() => _suggestions = pays);
    }
  }

  void _edit(Shift Function(Shift) change) {
    setState(() => _draft = change(_draft));
  }

  Future<void> _save() async {
    final shift = _draft.copyWith(
      notes: _notes.text.trim(),
      location: _location.text.trim(),
      updatedAt: DateTime.now(),
    );

    await ref.read(scheduleRepositoryProvider).upsertShift(shift);
    talker.info('Shift saved: ${shift.id} ${shift.pay}');

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    await ref.read(scheduleRepositoryProvider).deleteShift(_draft.id);
    talker.info('Shift deleted: ${_draft.id}');

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final currency = ref.watch(settingsProvider.select((s) => s.currency));
    final template = ref.watch(templatesByIdProvider)[_draft.templateId];
    final color = template?.color ?? fallbackShiftColor;
    final tint = context.tint(color);

    return EntrySheetLayout(
      header: EntrySheetHeader(
        color: tint.strong,
        foreground: tint.text,
        leading: ShiftAvatar(icon: template?.icon ?? '', color: color, size: 40),
        title: template?.title ?? l.shift,
        subtitle: formatDayHeader(context, _draft.day),
        badge: formatDuration(context, _draft.workedMinutes),
      ),
      onDelete: _delete,
      onSave: _save,
      children: [
        TimeFields(
          allDay: _draft.allDay,
          startMinute: _draft.startMinute,
          endMinute: _draft.endMinute,
          breakMinutes: _draft.breakMinutes,
          onAllDay: (value) => _edit((s) => s.copyWith(allDay: value)),
          onStart: (value) => _edit((s) => s.copyWith(startMinute: value)),
          onEnd: (value) => _edit((s) => s.copyWith(endMinute: value)),
          onBreak: (value) => _edit((s) => s.copyWith(breakMinutes: value)),
        ),
        PaySectionLabel(earned: _draft.earned, currency: currency),
        PayEditor(
          value: _draft.pay,
          workedMinutes: _draft.workedMinutes,
          currency: currency,
          suggestions: _suggestions,
          onChanged: (pay) => _edit((s) => s.copyWith(pay: pay)),
        ),
        const SizedBox(height: 12),
        NotesCard(notes: _notes, location: _location),
        AttachmentsSection(shiftId: _draft.id),
      ],
    );
  }
}
