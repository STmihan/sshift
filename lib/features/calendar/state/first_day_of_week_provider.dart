import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/settings_controller.dart';

int firstDayOfWeekOf(BuildContext context, WidgetRef ref) {
  return ref.watch(settingsProvider.select((s) => s.firstDayOfWeek)) ??
      MaterialLocalizations.of(context).firstDayOfWeekIndex;
}
