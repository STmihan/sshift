import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../domain/models/shift_template.dart';
import 'template_tile.dart';

class ReorderableTemplateList extends StatelessWidget {
  const ReorderableTemplateList({required this.templates, required this.onReorder, super.key});

  final List<ShiftTemplate> templates;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Material(
      color: p.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: p.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        buildDefaultDragHandles: false,
        itemCount: templates.length,
        onReorderItem: onReorder,
        proxyDecorator: (child, _, _) {
          return Material(color: p.card, elevation: 6, shadowColor: p.shadow.withValues(alpha: 0.3), child: child);
        },
        itemBuilder: (context, index) {
          final template = templates[index];

          return Column(
            key: ValueKey(template.id),
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index > 0) Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: p.divider),
              TemplateTile(
                template: template,
                trailing: ReorderableDragStartListener(
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.drag_handle_rounded, color: p.textSecondary),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
