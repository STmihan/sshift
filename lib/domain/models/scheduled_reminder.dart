import 'package:flutter/foundation.dart';

@immutable
class ScheduledReminder {
  const ScheduledReminder({
    required this.id,
    required this.at,
    required this.title,
    required this.body,
    required this.dayKey,
  });

  final int id;
  final DateTime at;
  final String title;
  final String body;
  final int dayKey;
}
