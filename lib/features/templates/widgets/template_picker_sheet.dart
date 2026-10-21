import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/group_card.dart';
import '../../../core/widgets/sheet_header.dart';
import '../../../domain/models/shift_template.dart';
import '../../../l10n/app_localizations.dart';
import '../template_navigation.dart';
import '../templates_providers.dart';
import 'add_template_tile.dart';
import 'template_tile.dart';

Future<ShiftTemplate?> pickTemplate(BuildContext context) {
  return showAppSheet<ShiftTemplate>(context, (_) => const TemplatePickerSheet());
}

class TemplatePickerSheet extends ConsumerWidget {
  const TemplatePickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(templatesProvider).value ?? const [];

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetHeader(AppLocalizations.of(context).shift),
            GroupCard(
              children: [
                for (final t in templates) TemplateTile(template: t, onTap: () => Navigator.of(context).pop(t)),
                AddTemplateTile(
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    final created = await openTemplateEditor(context);

                    if (created != null) {
                      navigator.pop(created);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
