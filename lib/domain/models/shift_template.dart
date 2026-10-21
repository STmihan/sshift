import 'package:flutter/foundation.dart';

import 'pay.dart';
import 'time_span.dart';

@immutable
class ShiftTemplate with TimeSpan {
  const ShiftTemplate({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.updatedAt,
    this.allDay = false,
    this.startMinute = 9 * 60,
    this.endMinute = 17 * 60,
    this.breakMinutes = 0,
    this.defaultPay = Pay.none,
    this.location = '',
    this.sortOrder = 0,
  });

  final String id;
  final String title;
  final String icon;
  final int color;
  @override
  final bool allDay;
  @override
  final int startMinute;
  @override
  final int endMinute;
  @override
  final int breakMinutes;
  final Pay defaultPay;
  final String location;
  final int sortOrder;
  final DateTime updatedAt;

  ShiftTemplate copyWith({
    String? title,
    String? icon,
    int? color,
    bool? allDay,
    int? startMinute,
    int? endMinute,
    int? breakMinutes,
    Pay? defaultPay,
    String? location,
    int? sortOrder,
    DateTime? updatedAt,
  }) {
    return ShiftTemplate(
      id: id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      allDay: allDay ?? this.allDay,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      defaultPay: defaultPay ?? this.defaultPay,
      location: location ?? this.location,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
