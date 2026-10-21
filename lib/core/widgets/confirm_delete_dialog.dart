import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme/theme_context.dart';

Future<bool> confirmDelete(BuildContext context, {required String title, String? body}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => ConfirmDeleteDialog(title: title, body: body),
  );

  return confirmed ?? false;
}

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({required this.title, this.body, super.key});

  final String title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;

    return AlertDialog(
      title: Text(title),
      content: body == null ? null : Text(body!),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l.cancel, style: TextStyle(color: p.text)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l.delete, style: TextStyle(color: p.danger)),
        ),
      ],
    );
  }
}
