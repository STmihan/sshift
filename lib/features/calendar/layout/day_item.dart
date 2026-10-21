import 'package:flutter/foundation.dart';

import '../../../domain/models/calendar_event.dart';
import '../../../domain/models/shift.dart';
import 'day_item_kind.dart';
import 'month_layout.dart';

@immutable
class DayItem {
  const DayItem.fullShift(Shift this.shift) : kind = DayItemKind.fullShift, event = null, hiddenCount = 0;

  const DayItem.shiftLine(Shift this.shift) : kind = DayItemKind.shiftLine, event = null, hiddenCount = 0;

  const DayItem.eventLine(CalendarEvent this.event) : kind = DayItemKind.eventLine, shift = null, hiddenCount = 0;

  const DayItem.slot() : kind = DayItemKind.slot, shift = null, event = null, hiddenCount = 0;

  const DayItem.more(this.hiddenCount) : kind = DayItemKind.more, shift = null, event = null;

  final DayItemKind kind;
  final Shift? shift;
  final CalendarEvent? event;
  final int hiddenCount;

  double get height => switch (kind) {
    DayItemKind.fullShift || DayItemKind.slot => fullChipHeight,
    DayItemKind.shiftLine || DayItemKind.eventLine || DayItemKind.more => lineHeight,
  };
}
