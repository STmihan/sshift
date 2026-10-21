import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/shell/nav_bar_metrics.dart';
import '../../core/theme/theme_context.dart';
import '../../core/widgets/centered_content.dart';
import '../../core/widgets/group_card.dart';
import '../../core/widgets/page_header.dart';
import '../../l10n/app_localizations.dart';
import 'template_navigation.dart';
import 'templates_providers.dart';
import 'widgets/add_template_tile.dart';
import 'widgets/template_tile.dart';

class TemplatesScreen extends ConsumerWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final templates = ref.watch(templatesProvider).value ?? const [];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.only(bottom: navBarBottomReserve(context)),
          children: [
            PageHeader(title: AppLocalizations.of(context).navShifts),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CenteredContent(
                child: GroupCard(
                  children: [
                    for (final t in templates)
                      TemplateTile(
                        template: t,
                        onTap: () => openTemplateEditor(context, id: t.id),
                        trailing: Icon(Icons.chevron_right_rounded, color: p.textSecondary),
                      ),
                    AddTemplateTile(onTap: () => openTemplateEditor(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
