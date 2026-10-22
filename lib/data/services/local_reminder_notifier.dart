import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/models/scheduled_reminder.dart';
import '../../domain/services/reminder_notifier.dart';

class LocalReminderNotifier implements ReminderNotifier {
  static const _channelId = 'reminders';
  static const _icon = 'ic_notification';

  final _plugin = FlutterLocalNotificationsPlugin();
  final _ready = Completer<void>();

  AndroidFlutterLocalNotificationsPlugin? get _android =>
      _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  @override
  Future<void> initialize({required void Function(int dayKey) onOpenDay}) async {
    if (_ready.isCompleted) {
      return;
    }

    try {
      tz.initializeTimeZones();
      final zone = await FlutterTimezone.getLocalTimezone();

      tz.setLocalLocation(tz.getLocation(zone.identifier));
      await _plugin.initialize(
        settings: const InitializationSettings(android: AndroidInitializationSettings(_icon)),
        onDidReceiveNotificationResponse: (response) {
          _open(response.payload, onOpenDay);
        },
      );

      final launch = await _plugin.getNotificationAppLaunchDetails();

      if (launch != null && launch.didNotificationLaunchApp) {
        _open(launch.notificationResponse?.payload, onOpenDay);
      }
    } finally {
      _ready.complete();
    }
  }

  @override
  Future<bool> requestPermission() async {
    await _ready.future;

    return await _android?.requestNotificationsPermission() ?? true;
  }

  @override
  Future<void> replaceAll(List<ScheduledReminder> reminders, {required String channelName}) async {
    await _ready.future;
    await _plugin.cancelAllPendingNotifications();

    final exact = await _android?.canScheduleExactNotifications() ?? false;
    final mode = exact ? AndroidScheduleMode.exactAllowWhileIdle : AndroidScheduleMode.inexactAllowWhileIdle;
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        channelName,
        importance: Importance.high,
        priority: Priority.high,
        category: AndroidNotificationCategory.reminder,
      ),
    );

    for (final reminder in reminders) {
      await _plugin.zonedSchedule(
        id: reminder.id,
        scheduledDate: tz.TZDateTime.from(reminder.at, tz.local),
        notificationDetails: details,
        androidScheduleMode: mode,
        title: reminder.title,
        body: reminder.body,
        payload: '${reminder.dayKey}',
      );
    }
  }

  @override
  Future<void> cancelAll() async {
    await _ready.future;
    await _plugin.cancelAllPendingNotifications();
  }

  void _open(String? payload, void Function(int dayKey) onOpenDay) {
    final dayKey = int.tryParse(payload ?? '');

    if (dayKey != null) {
      onOpenDay(dayKey);
    }
  }
}
