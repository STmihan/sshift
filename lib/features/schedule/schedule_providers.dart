import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/dates.dart';
import '../../data/data_providers.dart';
import '../../domain/models/calendar_event.dart';
import '../../domain/models/shift.dart';
import 'day_entries.dart';
import 'day_range.dart';

final shiftsInRangeProvider = StreamProvider.autoDispose.family<List<Shift>, DayRange>(
  (ref, range) => ref.watch(scheduleRepositoryProvider).watchShifts(fromDayKey(range.from), fromDayKey(range.to)),
);

final eventsInRangeProvider = StreamProvider.autoDispose.family<List<CalendarEvent>, DayRange>(
  (ref, range) => ref.watch(scheduleRepositoryProvider).watchEvents(fromDayKey(range.from), fromDayKey(range.to)),
);

final dayEntriesProvider = Provider.autoDispose.family<DayEntries, int>((ref, key) {
  final day = fromDayKey(key);
  final range = dayRange(day, addDays(day, 1));

  return (
    shifts: ref.watch(shiftsInRangeProvider(range)).value ?? const [],
    events: ref.watch(eventsInRangeProvider(range)).value ?? const [],
  );
});
