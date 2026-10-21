import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'templates_providers.dart';
import 'widgets/template_editor_form.dart';

class TemplateEditorScreen extends ConsumerWidget {
  const TemplateEditorScreen({this.templateId, super.key});

  final String? templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(templatesProvider).value;

    if (templates == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final template = templates.where((t) => t.id == templateId).firstOrNull;

    return TemplateEditorForm(
      key: ValueKey(template?.id),
      template: template,
      newSortOrder: templates.length,
    );
  }
}
