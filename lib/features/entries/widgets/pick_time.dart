import 'package:flutter/material.dart';

Future<int?> pickTime(BuildContext context, int minute) async {
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: minute ~/ 60, minute: minute % 60),
  );

  return time == null ? null : time.hour * 60 + time.minute;
}
