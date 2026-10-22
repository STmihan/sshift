import '../models/scheduled_reminder.dart';

abstract interface class ReminderNotifier {
  Future<void> initialize({required void Function(int dayKey) onOpenDay});

  Future<bool> requestPermission();

  Future<void> replaceAll(List<ScheduledReminder> reminders, {required String channelName});

  Future<void> cancelAll();
}
