import '../../core/id.dart';
import '../../core/utils/dates.dart';
import '../../domain/models/calendar_event.dart';
import '../../domain/models/time_span.dart';

CalendarEvent draftEvent(DateTime day) {
  final start = (DateTime.now().hour + 1).clamp(0, 23) * 60;

  return CalendarEvent(
    id: newId(),
    day: dateOnly(day),
    title: '',
    startMinute: start,
    endMinute: (start + 60) % minutesPerDay,
    updatedAt: DateTime.now(),
  );
}
