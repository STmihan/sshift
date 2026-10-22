import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/shell/nav_bar_metrics.dart';
import '../../core/logger.dart';
import '../../core/theme/theme_context.dart';
import '../../core/widgets/centered_content.dart';
import '../../core/widgets/circle_button.dart';
import '../../core/widgets/group_card.dart';
import '../../core/widgets/page_header.dart';
import '../../data/data_providers.dart';
import '../../domain/models/shift_template.dart';
import '../../l10n/app_localizations.dart';
import 'template_navigation.dart';
import 'templates_providers.dart';
import 'widgets/add_template_tile.dart';
import 'widgets/reorderable_template_list.dart';
import 'widgets/template_tile.dart';

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() {
    return _TemplatesScreenState();
  }
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen> {
  bool _reordering = false;
  List<ShiftTemplate>? _pendingOrder;

  void _toggleReordering() {
    setState(() {
      _reordering = !_reordering;
      _pendingOrder = null;
    });
  }

  void _reorder(List<ShiftTemplate> templates, int oldIndex, int newIndex) {
    final order = [...templates];
    final moved = order.removeAt(oldIndex);

    order.insert(newIndex, moved);
    setState(() {
      _pendingOrder = order;
    });
    unawaited(_save(order));
  }

  Future<void> _save(List<ShiftTemplate> order) async {
    try {
      await ref.read(templatesRepositoryProvider).reorder([for (final t in order) t.id]);
      talker.info('Shift types reordered');
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Shift types reorder failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final templates = _pendingOrder ?? ref.watch(templatesProvider).value ?? const <ShiftTemplate>[];
    final canReorder = templates.length > 1;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.only(bottom: navBarBottomReserve(context)),
          children: [
            PageHeader(
              title: AppLocalizations.of(context).navShifts,
              trailing: canReorder || _reordering
                  ? CircleButton(
                      icon: _reordering ? Icons.check_rounded : Icons.swap_vert_rounded,
                      onTap: _toggleReordering,
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CenteredContent(
                child: _reordering
                    ? ReorderableTemplateList(
                        templates: templates,
                        onReorder: (oldIndex, newIndex) => _reorder(templates, oldIndex, newIndex),
                      )
                    : GroupCard(
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
