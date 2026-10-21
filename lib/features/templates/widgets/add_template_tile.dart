import 'package:flutter/material.dart';

import '../../../core/theme/dimensions.dart';
import '../../../core/theme/theme_context.dart';
import '../../../l10n/app_localizations.dart';

class AddTemplateTile extends StatelessWidget {
  const AddTemplateTile({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: rowInset, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: p.accent, shape: BoxShape.circle),
              child: Icon(Icons.add_rounded, color: p.onAccent, size: 20),
            ),
            const SizedBox(width: 12),
            Text(AppLocalizations.of(context).addShift, style: TextStyle(fontSize: 15, color: p.text)),
          ],
        ),
      ),
    );
  }
}
