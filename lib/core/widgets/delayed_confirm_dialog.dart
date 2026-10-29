import 'dart:async';

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme/theme_context.dart';

Future<bool> confirmWithDelay(
  BuildContext context, {
  required String title,
  required String body,
  required Duration delay,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => DelayedConfirmDialog(title: title, body: body, delay: delay),
  );

  return confirmed ?? false;
}

class DelayedConfirmDialog extends StatefulWidget {
  const DelayedConfirmDialog({required this.title, required this.body, required this.delay, super.key});

  final String title;
  final String body;
  final Duration delay;

  @override
  State<DelayedConfirmDialog> createState() {
    return _DelayedConfirmDialogState();
  }
}

class _DelayedConfirmDialogState extends State<DelayedConfirmDialog> {
  static const _tick = Duration(seconds: 1);

  late int _secondsLeft = widget.delay.inSeconds;
  late final Timer _timer;

  bool get _ready => _secondsLeft <= 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_tick, _onTick);
  }

  void _onTick(Timer timer) {
    setState(() {
      _secondsLeft--;
    });

    if (_ready) {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;

    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l.cancel, style: TextStyle(color: p.text)),
        ),
        TextButton(
          onPressed: _ready ? () => Navigator.of(context).pop(true) : null,
          child: Text(
            _ready ? l.yes : l.yesCountdown(_secondsLeft),
            style: TextStyle(color: _ready ? p.danger : p.textMuted),
          ),
        ),
      ],
    );
  }
}
