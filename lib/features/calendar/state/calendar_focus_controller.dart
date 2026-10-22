import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarFocusProvider = NotifierProvider<CalendarFocusController, DateTime?>(CalendarFocusController.new);

class CalendarFocusController extends Notifier<DateTime?> {
  @override
  DateTime? build() {
    return null;
  }

  void focus(DateTime month) {
    state = month;
  }

  void clear() {
    state = null;
  }
}
