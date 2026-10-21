import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/widgets/circle_button.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../l10n/app_localizations.dart';

class EntrySheetLayout extends StatelessWidget {
  const EntrySheetLayout({
    required this.header,
    required this.children,
    required this.onSave,
    this.onDelete,
    super.key,
  });

  final Widget header;
  final List<Widget> children;
  final VoidCallback onSave;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final deleteTap = onDelete;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Row(
              children: [
                if (deleteTap != null) ...[
                  CircleButton(
                    icon: Icons.delete_outline_rounded,
                    onTap: deleteTap,
                    size: 50,
                    color: context.palette.danger,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: PillButton(label: AppLocalizations.of(context).save, onTap: onSave),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
