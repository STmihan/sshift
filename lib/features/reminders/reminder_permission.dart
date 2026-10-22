import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_providers.dart';
import '../../l10n/app_localizations.dart';

Future<void> requestReminderPermission(BuildContext context, WidgetRef ref) async {
  final messenger = ScaffoldMessenger.of(context);
  final deniedText = AppLocalizations.of(context).notificationsDenied;
  final granted = await ref.read(reminderNotifierProvider).requestPermission();

  if (!granted) {
    messenger.showSnackBar(SnackBar(content: Text(deniedText)));
  }
}
