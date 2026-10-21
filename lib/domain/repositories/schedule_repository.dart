import '../models/calendar_event.dart';
import '../models/pay.dart';
import '../models/shift.dart';

abstract interface class ScheduleRepository {
  Stream<List<Shift>> watchShifts(DateTime from, DateTime to);

  Future<List<Shift>> getShifts(DateTime from, DateTime to);

  Stream<List<CalendarEvent>> watchEvents(DateTime from, DateTime to);

  Future<void> upsertShift(Shift shift);

  Future<void> deleteShift(String id);

  Future<void> upsertEvent(CalendarEvent event);

  Future<void> deleteEvent(String id);

  Future<List<Pay>> recentShiftPays(String templateId, {int limit = 5});

  Future<List<Pay>> recentEventPays(String title, {int limit = 5});
}
