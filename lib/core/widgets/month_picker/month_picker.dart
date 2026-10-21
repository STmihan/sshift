import 'package:flutter/material.dart';

import '../../utils/dates.dart';
import '../app_sheet.dart';
import 'month_picker_sheet.dart';

Future<DateTime?> pickMonth(BuildContext context, DateTime initial) async {
  final picked = await showAppSheet<Set<DateTime>>(
    context,
    (_) => MonthPickerSheet(initial: {monthStart(initial)}, multiple: false),
  );

  return picked?.single;
}

Future<Set<DateTime>?> pickMonths(BuildContext context, Set<DateTime> initial) {
  return showAppSheet<Set<DateTime>>(
    context,
    (_) => MonthPickerSheet(initial: {for (final month in initial) monthStart(month)}, multiple: true),
  );
}
