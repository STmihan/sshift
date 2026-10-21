import 'package:flutter/foundation.dart';

import 'pay.dart';
import 'time_span.dart';

@immutable
class CalendarEvent with TimeSpan {
  const CalendarEvent({
    required this.id,
    required this.day,
    required this.title,
    required this.startMinute,
    required this.endMinute,
    required this.updatedAt,
    this.allDay = false,
    this.notes = '',
    this.location = '',
    this.pay = Pay.none,
  });

  final String id;
  final DateTime day;
  final String title;
  @override
  final bool allDay;
  @override
  final int startMinute;
  @override
  final int endMinute;
  final String notes;
  final String location;
  final Pay pay;
  final DateTime updatedAt;

  int get earned => pay.totalFor(workedMinutes);

  CalendarEvent copyWith({
    String? title,
    bool? allDay,
    int? startMinute,
    int? endMinute,
    String? notes,
    String? location,
    Pay? pay,
    DateTime? updatedAt,
  }) {
    return CalendarEvent(
      id: id,
      day: day,
      title: title ?? this.title,
      allDay: allDay ?? this.allDay,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      pay: pay ?? this.pay,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
