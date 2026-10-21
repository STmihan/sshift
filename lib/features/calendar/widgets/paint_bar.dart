import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/widgets/shift_avatar.dart';
import '../../../l10n/app_localizations.dart';
import '../../templates/template_navigation.dart';
import '../../templates/templates_providers.dart';
import '../state/paint_mode_controller.dart';
import 'paint_bar_item.dart';

class PaintBar extends ConsumerWidget {
  const PaintBar({super.key});

  static const height = 76.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final foreground = p.onPopover;
    final templates = ref.watch(templatesProvider).value ?? const [];
    final selectedId = ref.watch(paintModeProvider)?.templateId;
    final controller = ref.read(paintModeProvider.notifier);

    return Material(
      color: p.popover,
      elevation: 10,
      shadowColor: p.shadow.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              child: templates.isEmpty
                  ? Center(
                      child: Text(
                        l.paintHint,
                        style: TextStyle(fontSize: 13, color: foreground.withValues(alpha: 0.7)),
                      ),
                    )
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      children: [
                        for (final t in templates)
                          PaintBarItem(
                            icon: ShiftAvatar(icon: t.icon, color: t.color, size: 26),
                            label: t.title,
                            selected: t.id == selectedId,
                            onTap: () => controller.select(t.id),
                          ),
                      ],
                    ),
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              indent: 14,
              endIndent: 14,
              color: foreground.withValues(alpha: 0.15),
            ),
            PaintBarItem(
              icon: Icon(Icons.add_rounded, size: 26, color: foreground),
              label: l.newShift,
              selected: false,
              onTap: () async {
                final created = await openTemplateEditor(context);

                if (created != null) {
                  controller.select(created.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
