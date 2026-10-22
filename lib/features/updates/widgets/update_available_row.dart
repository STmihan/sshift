import 'package:flutter/material.dart';

import '../../../core/theme/dimensions.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/widgets/notification_dot.dart';
import '../../../domain/models/app_update.dart';
import '../../../l10n/app_localizations.dart';
import 'update_badge.dart';

class UpdateAvailableRow extends StatelessWidget {
  const UpdateAvailableRow({required this.update, required this.onTap, super.key});

  final AppUpdate update;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(horizontal: rowInset),
        child: Row(
          children: [
            const NotificationDot(size: 10),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppLocalizations.of(context).newVersionAvailable,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: p.text),
              ),
            ),
            UpdateBadge(version: update.version),
          ],
        ),
      ),
    );
  }
}
