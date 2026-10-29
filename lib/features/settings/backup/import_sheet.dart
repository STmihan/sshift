import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logger.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/field_row.dart';
import '../../../core/widgets/group_card.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/sheet_header.dart';
import '../../../data/data_providers.dart';
import '../../../domain/models/backup_format_exception.dart';
import '../../../domain/models/backup_info.dart';
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

  var _restoring = false;
  String? _error;

  Future<void> _restore() async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() {
      _restoring = true;
      _error = null;
    });

    try {
      await ref.read(backupRepositoryProvider).restore(widget.path);
      talker.info('Backup from ${widget.info.exportedAt} restored');
      messenger.showSnackBar(SnackBar(content: Text(l.backupImportDone)));

      if (mounted) {
        navigator.pop();
      }
    } on BackupFormatException catch (error, stack) {
      talker.handle(error, stack, 'Backup restore rejected');
      _fail(backupRejectionText(l, error.reason));
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Backup restore failed');
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

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final error = _error;

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
              const SizedBox(height: 16),
              Text(
                error ?? l.backupImportWarning,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, height: 1.4, color: error != null ? p.danger : p.textSecondary),
              ),
              const SizedBox(height: 16),
              if (_restoring)
                const SizedBox(
                  height: _progressHeight,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                )
              else ...[
                PillButton(label: l.backupImportAction, icon: Icons.restore_rounded, onTap: _restore),
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
