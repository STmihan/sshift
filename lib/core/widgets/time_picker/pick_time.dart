import 'package:flutter/material.dart';

import '../app_sheet.dart';
import 'time_picker_sheet.dart';

Future<int?> pickTime(BuildContext context, {required String title, required int minute}) {
  return showAppSheet<int>(context, (_) {
    return TimePickerSheet(title: title, initialMinute: minute);
  });
}
