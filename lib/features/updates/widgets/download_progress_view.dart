import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/models/download_progress.dart';
import '../../../l10n/app_localizations.dart';

class DownloadProgressView extends StatelessWidget {
  const DownloadProgressView({required this.progress, super.key});

  final DownloadProgress? progress;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final current = progress;
    final fraction = current?.fraction;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 8,
            color: p.accent,
            backgroundColor: p.selected,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          current == null || fraction == null
              ? l.downloadingUpdate
              : l.downloadProgress(
                  formatMegabytes(context, current.received),
                  formatMegabytes(context, current.total),
                  (fraction * 100).round(),
                ),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: p.textSecondary),
        ),
      ],
    );
  }
}
