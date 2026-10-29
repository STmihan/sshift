import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logger.dart';
import '../../../data/data_providers.dart';
import '../../../domain/models/backup_format_exception.dart';
import '../../../l10n/app_localizations.dart';
import 'backup_rejection_text.dart';
import 'import_sheet.dart';

Future<void> importBackup(BuildContext context, WidgetRef ref) async {
  final l = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);

  void showError(String message) {
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  final picked = await FilePicker.pickFile();

  if (picked == null) {
    return;
  }

  final path = picked.path;

  try {
    if (path == null) {
      talker.warning('Picked backup ${picked.uri} is not a local file');
      showError(l.backupImportFailed);

      return;
    }

    final info = await ref.read(backupRepositoryProvider).inspect(path);

    if (context.mounted) {
      await showImportSheet(context, path: path, info: info);
    }
  } on BackupFormatException catch (error, stack) {
    talker.handle(error, stack, 'Backup file rejected');
    showError(backupRejectionText(l, error.reason));
  } on Exception catch (error, stack) {
    talker.handle(error, stack, 'Backup file could not be read');
    showError(l.backupImportFailed);
  } finally {
    await _clearPickedFiles();
  }
}

Future<void> _clearPickedFiles() async {
  try {
    await FilePicker.clearTemporaryFiles();
  } on Exception catch (error, stack) {
    talker.handle(error, stack, 'Clearing picked files failed');
  }
}
