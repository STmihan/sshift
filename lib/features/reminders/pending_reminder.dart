import 'package:flutter/foundation.dart';

@immutable
class PendingReminder {
  const PendingReminder({
    required this.at,
    required this.day,
    required this.title,
    required this.allDay,
    required this.startMinute,
    required this.endMinute,
  });

  final DateTime at;
  final DateTime day;
  final String? title;
  final bool allDay;
  final int startMinute;
  final int endMinute;
}
