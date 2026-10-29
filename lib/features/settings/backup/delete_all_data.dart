import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logger.dart';
import '../../../core/widgets/delayed_confirm_dialog.dart';
import '../../../data/data_providers.dart';
import '../../../l10n/app_localizations.dart';

const _confirmDelay = Duration(seconds: 5);

Future<void> deleteAllData(BuildContext context, WidgetRef ref) async {
  final l = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final confirmed = await confirmWithDelay(
    context,
    title: l.dataDeleteAllTitle,
    body: l.dataDeleteAllBody,
    delay: _confirmDelay,
  );

  if (!confirmed) {
    return;
  }

  try {
    await ref.read(backupRepositoryProvider).deleteAll();
    talker.info('All local data deleted');
    messenger.showSnackBar(SnackBar(content: Text(l.dataDeleted)));
  } on Exception catch (error, stack) {
    talker.handle(error, stack, 'Deleting all data failed');
    messenger.showSnackBar(SnackBar(content: Text(l.dataDeleteFailed)));
  }
}
