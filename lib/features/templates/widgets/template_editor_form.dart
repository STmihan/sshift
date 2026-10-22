import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/id.dart';
import '../../../core/logger.dart';
import '../../../core/theme/shift_colors.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/utils/initials.dart';
import '../../../core/widgets/centered_content.dart';
import '../../../core/widgets/circle_button.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../../core/widgets/group_card.dart';
import '../../../core/widgets/inline_text_field.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/section_label.dart';
import '../../../core/widgets/shift_avatar.dart';
import '../../../data/data_providers.dart';
import '../../../domain/models/shift_template.dart';
import '../../../l10n/app_localizations.dart';
import '../../entries/widgets/pay/pay_editor.dart';
import '../../entries/widgets/time_fields.dart';
import '../../reminders/reminder_permission.dart';
import '../../settings/settings_controller.dart';
import 'color_picker.dart';

class TemplateEditorForm extends ConsumerStatefulWidget {
  const TemplateEditorForm({required this.template, required this.newSortOrder, super.key});

  final ShiftTemplate? template;
  final int newSortOrder;

  @override
  ConsumerState<TemplateEditorForm> createState() {
    return _TemplateEditorFormState();
  }
}

class _TemplateEditorFormState extends ConsumerState<TemplateEditorForm> {
  static const _maxIconLength = 3;

  late ShiftTemplate _draft =
      widget.template ??
      ShiftTemplate(
        id: newId(),
        title: '',
        icon: '',
        color: shiftColors[widget.newSortOrder % shiftColors.length],
        sortOrder: widget.newSortOrder,
        updatedAt: DateTime.now(),
      );
  late final _title = TextEditingController(text: _draft.title);
  late final _icon = TextEditingController(text: _draft.icon);
  late final _location = TextEditingController(text: _draft.location);
  late bool _iconEdited = widget.template != null && _draft.icon != initialsOf(_draft.title);

  bool get _isNew => widget.template == null;

  String get _effectiveIcon => _icon.text.trim().isEmpty ? initialsOf(_title.text) : _icon.text.trim().toUpperCase();

  @override
  void dispose() {
    _title.dispose();
    _icon.dispose();
    _location.dispose();
    super.dispose();
  }

  void _edit(ShiftTemplate Function(ShiftTemplate) change) {
    setState(() => _draft = change(_draft));
  }

  Future<void> _save() async {
    final template = _draft.copyWith(
      title: _title.text.trim(),
      icon: _effectiveIcon,
      location: _location.text.trim(),
      updatedAt: DateTime.now(),
    );

    await ref.read(templatesRepositoryProvider).upsert(template);
    talker.info('Shift type saved: ${template.title} (${template.id})');

    if (mounted) {
      Navigator.of(context).pop(template);
    }
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context);

    if (!await confirmDelete(context, title: l.deleteShiftTypeTitle, body: l.deleteShiftTypeBody)) {
      return;
    }

    await ref.read(templatesRepositoryProvider).delete(_draft.id);
    talker.info('Shift type deleted: ${_draft.id}');

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final currency = ref.watch(settingsProvider.select((s) => s.currency));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  CircleButton(icon: Icons.chevron_left_rounded, onTap: () => Navigator.of(context).pop()),
                  Expanded(
                    child: Text(
                      _isNew ? l.newShift : l.shift,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  if (_isNew)
                    const SizedBox(width: 40)
                  else
                    CircleButton(icon: Icons.delete_outline_rounded, onTap: _delete, color: p.danger),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: CenteredContent(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ShiftAvatar(icon: _effectiveIcon, color: _draft.color, size: 64),
                      ),
                      const SizedBox(height: 16),
                      GroupCard(
                        children: [
                          InlineTextField(
                            controller: _title,
                            hint: l.title,
                            autofocus: _isNew,
                            onChanged: (value) => setState(() {
                              if (!_iconEdited) {
                                _icon.text = initialsOf(value);
                              }
                            }),
                          ),
                          InlineTextField(
                            controller: _icon,
                            hint: l.icon,
                            maxLength: _maxIconLength,
                            textCapitalization: TextCapitalization.characters,
                            onChanged: (_) => setState(() => _iconEdited = true),
                          ),
                        ],
                      ),
                      SectionLabel(l.color),
                      ColorPicker(
                        selected: _draft.color,
                        onChanged: (color) => _edit((t) => t.copyWith(color: color)),
                      ),
                      SectionLabel(l.defaultValues),
                      TimeFields(
                        allDay: _draft.allDay,
                        startMinute: _draft.startMinute,
                        endMinute: _draft.endMinute,
                        breakMinutes: _draft.breakMinutes,
                        onAllDay: (value) {
                          _edit(
                            (t) => t.copyWith(
                              allDay: value,
                              reminder: () => t.reminder?.convertedFor(allDay: value),
                            ),
                          );
                        },
                        onStart: (value) => _edit((t) => t.copyWith(startMinute: value)),
                        onEnd: (value) => _edit((t) => t.copyWith(endMinute: value)),
                        onBreak: (value) => _edit((t) => t.copyWith(breakMinutes: value)),
                        reminder: _draft.reminder,
                        onReminder: (value) {
                          _edit((t) => t.copyWith(reminder: () => value));

                          if (value != null) {
                            unawaited(requestReminderPermission(context, ref));
                          }
                        },
                      ),
                      SectionLabel(l.defaultPay),
                      PayEditor(
                        value: _draft.defaultPay,
                        workedMinutes: _draft.workedMinutes,
                        currency: currency,
                        onChanged: (pay) => _edit((t) => t.copyWith(defaultPay: pay)),
                      ),
                      const SizedBox(height: 12),
                      GroupCard(
                        children: [InlineTextField(controller: _location, hint: l.location)],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: CenteredContent(
                child: PillButton(label: l.save, onTap: _title.text.trim().isEmpty ? null : _save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
