import 'package:flutter/material.dart';

import '../../domain/models/time_format.dart';

class TimeFormatScope extends InheritedWidget {
  const TimeFormatScope({required this.format, required super.child, super.key});

  final TimeFormat format;

  static TimeFormat of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TimeFormatScope>()?.format ?? TimeFormat.system;
  }

  @override
  bool updateShouldNotify(TimeFormatScope oldWidget) {
    return oldWidget.format != format;
  }
}
