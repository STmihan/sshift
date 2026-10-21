import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logger.dart';
import '../../core/theme/theme_context.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_sheet.dart';
import '../../core/widgets/inline_text_field.dart';
import '../../data/data_providers.dart';
import '../../domain/models/calendar_event.dart';
import '../../domain/models/pay.dart';
import '../../l10n/app_localizations.dart';
import '../settings/settings_controller.dart';
import 'widgets/entry_sheet_header.dart';
import 'widgets/entry_sheet_layout.dart';
import 'widgets/notes_card.dart';
import 'widgets/pay/pay_editor.dart';
import 'widgets/pay_section_label.dart';
import 'widgets/time_fields.dart';

Future<void> showEventSheet(BuildContext context, CalendarEvent event, {bool isNew = false}) {
  return showAppSheet<void>(context, (_) => EventSheet(event: event, isNew: isNew));
}

class EventSheet extends ConsumerStatefulWidget {
  const EventSheet({required this.event, this.isNew = false, super.key});

  final CalendarEvent event;
  final bool isNew;

  @override
  ConsumerState<EventSheet> createState() {
    return _EventSheetState();
  }
}

class _EventSheetState extends ConsumerState<EventSheet> {
  static const _suggestionsDebounce = Duration(milliseconds: 300);

  late CalendarEvent _draft = widget.event;
  late final _title = TextEditingController(text: widget.event.title);
  late final _notes = TextEditingController(text: widget.event.notes);
  late final _location = TextEditingController(text: widget.event.location);
  List<Pay> _suggestions = const [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _title.dispose();
    _notes.dispose();
    _location.dispose();
    super.dispose();
  }

  Future<void> _loadSuggestions() async {
    final title = _title.text.trim();
    final pays = title.isEmpty ? const <Pay>[] : await ref.read(scheduleRepositoryProvider).recentEventPays(title);

    if (mounted) {
      setState(() => _suggestions = pays);
    }
  }

  void _onTitleChanged(String _) {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(_suggestionsDebounce, _loadSuggestions);
  }

  void _edit(CalendarEvent Function(CalendarEvent) change) {
    setState(() => _draft = change(_draft));
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    final event = _draft.copyWith(
      title: title.isEmpty ? AppLocalizations.of(context).untitled : title,
      notes: _notes.text.trim(),
      location: _location.text.trim(),
      updatedAt: DateTime.now(),
    );

    await ref.read(scheduleRepositoryProvider).upsertEvent(event);
    talker.info('Event saved: ${event.id} "${event.title}" ${event.pay}');

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    await ref.read(scheduleRepositoryProvider).deleteEvent(_draft.id);
    talker.info('Event deleted: ${_draft.id}');

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final currency = ref.watch(settingsProvider.select((s) => s.currency));
    final title = _title.text.trim();

    return EntrySheetLayout(
      header: EntrySheetHeader(
        color: p.event,
        foreground: p.onEvent,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: p.onEvent.withValues(alpha: 0.2), shape: BoxShape.circle),
          child: Icon(Icons.event_rounded, color: p.onEvent, size: 20),
        ),
        title: title.isEmpty ? l.event : title,
        subtitle: formatDayHeader(context, _draft.day),
        badge: formatDuration(context, _draft.spanMinutes),
      ),
      onDelete: widget.isNew ? null : _delete,
      onSave: _save,
      children: [
        TimeFields(
          leading: [
            InlineTextField(
              controller: _title,
              hint: l.title,
              autofocus: widget.isNew,
              onChanged: _onTitleChanged,
            ),
          ],
          allDay: _draft.allDay,
          startMinute: _draft.startMinute,
          endMinute: _draft.endMinute,
          onAllDay: (value) => _edit((e) => e.copyWith(allDay: value)),
          onStart: (value) => _edit((e) => e.copyWith(startMinute: value)),
          onEnd: (value) => _edit((e) => e.copyWith(endMinute: value)),
        ),
        PaySectionLabel(earned: _draft.earned, currency: currency),
        PayEditor(
          value: _draft.pay,
          workedMinutes: _draft.workedMinutes,
          currency: currency,
          suggestions: _suggestions,
          onChanged: (pay) => _edit((e) => e.copyWith(pay: pay)),
        ),
        const SizedBox(height: 12),
        NotesCard(notes: _notes, location: _location),
      ],
    );
  }
}
