import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/app_version_provider.dart';
import '../../../core/logger.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/group_card.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/sheet_header.dart';
import '../../../core/widgets/switch_row.dart';
import '../../../data/data_providers.dart';
import '../../../domain/models/backup_stats.dart';
import '../../../l10n/app_localizations.dart';
import 'backup_stats_provider.dart';
import 'widgets/backup_stat_rows.dart';

Future<void> showExportSheet(BuildContext context) {
  return showAppSheet<void>(context, (_) {
    return const ExportSheet();
  });
}

class ExportSheet extends ConsumerStatefulWidget {
  const ExportSheet({super.key});

  @override
  ConsumerState<ExportSheet> createState() {
    return _ExportSheetState();
  }
}

class _ExportSheetState extends ConsumerState<ExportSheet> {
  static const _backupMimeType = 'application/octet-stream';
  static const _progressHeight = 50.0;

  var _includeFiles = true;
  var _exporting = false;
  String? _error;

  Future<void> _export(BackupStats stats) async {
    final failedText = AppLocalizations.of(context).backupExportFailed;

    setState(() {
      _exporting = true;
      _error = null;
    });

    try {
      final appVersion = await ref.read(appVersionProvider.future);
      final path = await ref
          .read(backupRepositoryProvider)
          .export(includeAttachments: _includeFiles && stats.attachments > 0, appVersion: appVersion);

      talker.info('Backup exported to $path');
      await SharePlus.instance.share(ShareParams(files: [XFile(path, mimeType: _backupMimeType)]));

      if (mounted) {
        Navigator.of(context).pop();
      }
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Backup export failed');

      if (mounted) {
        setState(() {
          _exporting = false;
          _error = failedText;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final stats = ref.watch(backupStatsProvider).value;
    final error = _error;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetHeader(l.dataExport),
            if (stats == null)
              const SizedBox(
                height: _progressHeight,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              )
            else ...[
              GroupCard(children: backupStatRows(context, stats)),
              if (stats.attachments > 0) ...[
                const SizedBox(height: 12),
                GroupCard(
                  children: [
                    SwitchRow(
                      label: l.backupIncludeFiles,
                      value: _includeFiles,
                      onChanged: (value) {
                        setState(() {
                          _includeFiles = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ],
            const SizedBox(height: 16),
            if (error != null) ...[
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: p.danger),
              ),
              const SizedBox(height: 12),
            ],
            if (_exporting)
              const SizedBox(
                height: _progressHeight,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              )
            else
              PillButton(
                label: l.backupExportAction,
                icon: Icons.ios_share_rounded,
                onTap: stats == null ? null : () => _export(stats),
              ),
          ],
        ),
      ),
    );
  }
}
