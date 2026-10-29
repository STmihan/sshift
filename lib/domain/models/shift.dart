import 'package:flutter/foundation.dart';

import 'pay.dart';
import 'reminder.dart';
import 'time_span.dart';

@immutable
class Shift with TimeSpan {
  const Shift({
    required this.id,
    required this.templateId,
    required this.day,
    required this.allDay,
    required this.startMinute,
    required this.endMinute,
    required this.updatedAt,
    this.breakMinutes = 0,
    this.notes = '',
    this.location = '',
    this.pay = Pay.none,
    this.reminder,
  });

  final String id;
  final String templateId;
  final DateTime day;
  @override
  final bool allDay;
  @override
  final int startMinute;
  @override
  final int endMinute;
  @override
  final int breakMinutes;
  final String notes;
  final String location;
  final Pay pay;
  final Reminder? reminder;
  final DateTime updatedAt;

  int get earned => pay.totalFor(workedMinutes);

  Shift copyWith({
    String? templateId,
    bool? allDay,
    int? startMinute,
    int? endMinute,
    int? breakMinutes,
    String? notes,
    String? location,
    Pay? pay,
    Reminder? Function()? reminder,
    DateTime? updatedAt,
  }) {
    return Shift(
      id: id,
      templateId: templateId ?? this.templateId,
      day: day,
      allDay: allDay ?? this.allDay,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      pay: pay ?? this.pay,
      reminder: reminder != null ? reminder() : this.reminder,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
