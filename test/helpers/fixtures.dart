import 'package:sshift/core/utils/dates.dart';
import 'package:sshift/domain/models/pay.dart';
import 'package:sshift/domain/models/shift.dart';

Shift shiftOn(
  DateTime day, {
  String templateId = 't1',
  Pay pay = Pay.none,
  int start = 10 * 60,
  int end = 21 * 60,
  int breakMinutes = 0,
}) {
  return Shift(
    id: '${dayKey(day)}-$templateId-${pay.amount}',
    templateId: templateId,
    day: day,
    allDay: false,
    startMinute: start,
    endMinute: end,
    breakMinutes: breakMinutes,
    pay: pay,
    updatedAt: DateTime.now(),
  );
}
