import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logger.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/field_row.dart';
import '../../../core/widgets/group_card.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/pill_segments.dart';
import '../../../core/widgets/sheet_header.dart';
import '../../../data/data_providers.dart';
import '../../../domain/models/backup_format_exception.dart';
import '../../../domain/models/backup_import_mode.dart';
import '../../../domain/models/backup_info.dart';
import '../../../domain/models/backup_stats.dart';
import '../../../l10n/app_localizations.dart';
import 'backup_rejection_text.dart';
import 'widgets/backup_stat_rows.dart';

Future<void> showImportSheet(BuildContext context, {required String path, required BackupInfo info}) {
  return showAppSheet<void>(context, (_) {
    return ImportSheet(path: path, info: info);
  });
}

class ImportSheet extends ConsumerStatefulWidget {
  const ImportSheet({required this.path, required this.info, super.key});

  final String path;
  final BackupInfo info;

  @override
  ConsumerState<ImportSheet> createState() {
    return _ImportSheetState();
  }
}

class _ImportSheetState extends ConsumerState<ImportSheet> {
  static const _progressHeight = 50.0;
  static const _modes = [BackupImportMode.merge, BackupImportMode.replace];

  var _mode = BackupImportMode.merge;
  var _restoring = false;
  String? _error;

  Future<void> _restore() async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final mode = _mode;

    setState(() {
      _restoring = true;
      _error = null;
    });

    try {
      final written = await ref.read(backupRepositoryProvider).restore(widget.path, mode);

      talker.info('Backup from ${widget.info.exportedAt} imported (${mode.name}): ${_recordCount(written)} records');
      messenger.showSnackBar(SnackBar(content: Text(_doneText(l, mode, written))));

      if (mounted) {
        navigator.pop();
      }
    } on BackupFormatException catch (error, stack) {
      talker.handle(error, stack, 'Backup import rejected');
      _fail(backupRejectionText(l, error.reason));
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Backup import failed');
      _fail(l.backupImportFailed);
    }
  }

  void _fail(String message) {
    if (!mounted) {
      return;
    }

    setState(() {
      _restoring = false;
      _error = message;
    });
  }

  static int _recordCount(BackupStats stats) {
    return stats.templates + stats.shifts + stats.events;
  }

  static String _doneText(AppLocalizations l, BackupImportMode mode, BackupStats written) {
    return switch (mode) {
      BackupImportMode.merge => l.backupMergeDone(_recordCount(written)),
      BackupImportMode.replace => l.backupImportDone,
    };
  }

  String _modeLabel(AppLocalizations l, BackupImportMode mode) {
    return switch (mode) {
      BackupImportMode.merge => l.backupModeMerge,
      BackupImportMode.replace => l.backupModeReplace,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final error = _error;
    final replacing = _mode == BackupImportMode.replace;
    final hint = replacing ? l.backupImportWarning : l.backupMergeHint;

    return PopScope(
      canPop: !_restoring,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SheetHeader(l.dataImport),
              GroupCard(
                children: [
                  FieldRow(label: l.backupCreatedAt, value: formatDateTime(context, widget.info.exportedAt)),
                  ...backupStatRows(context, widget.info.stats),
                ],
              ),
              const SizedBox(height: 12),
              GroupCard(
                padding: const EdgeInsets.all(6),
                children: [
                  PillSegments<BackupImportMode>(
                    values: _modes,
                    labels: [for (final mode in _modes) _modeLabel(l, mode)],
                    selected: _mode,
                    onChanged: (mode) {
                      if (_restoring) {
                        return;
                      }

                      setState(() {
                        _mode = mode;
                        _error = null;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                error ?? hint,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: error != null || replacing ? p.danger : p.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              if (_restoring)
                const SizedBox(
                  height: _progressHeight,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                )
              else ...[
                PillButton(
                  label: replacing ? l.backupImportAction : l.backupMergeAction,
                  icon: replacing ? Icons.restore_rounded : Icons.download_rounded,
                  onTap: _restore,
                ),
                const SizedBox(height: 8),
                PillButton(label: l.cancel, filled: false, onTap: () => Navigator.of(context).pop()),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
