import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logger.dart';
import '../../core/utils/dates.dart';
import '../../data/data_providers.dart';
import '../../domain/models/scheduled_reminder.dart';
import '../schedule/day_range.dart';
import '../schedule/schedule_providers.dart';
import '../settings/settings_controller.dart';
import '../templates/templates_providers.dart';
import 'reminder_planner.dart';
import 'reminder_texts.dart';

final reminderSyncProvider = NotifierProvider<ReminderSync, void>(ReminderSync.new);

class ReminderSync extends Notifier<void> {
  static const windowDays = 60;
  static const maxScheduled = 400;
  static const _debounce = Duration(milliseconds: 500);

  Timer? _timer;
  late DayRange _range;

  @override
  void build() {
    final start = today();

    _range = dayRange(start, addDays(start, windowDays));
    ref.listen(shiftsInRangeProvider(_range), (_, _) => _schedule());
    ref.listen(eventsInRangeProvider(_range), (_, _) => _schedule());
    ref.listen(templatesProvider, (_, _) => _schedule());
    ref.listen(settingsProvider, (_, _) => _schedule());
    ref.onDispose(() => _timer?.cancel());
    _schedule();
  }

  void _schedule() {
    _timer?.cancel();
    _timer = Timer(_debounce, () => unawaited(_sync()));
  }

  Future<void> _sync() async {
    final settings = ref.read(settingsProvider);
    final notifier = ref.read(reminderNotifierProvider);

    try {
      if (!settings.notificationsEnabled) {
        await notifier.cancelAll();
        talker.info('Reminders disabled, pending notifications cancelled');

        return;
      }

      final shifts = ref.read(shiftsInRangeProvider(_range)).value;
      final events = ref.read(eventsInRangeProvider(_range)).value;

      if (shifts == null || events == null) {
        return;
      }

      final now = DateTime.now();
      final texts = ReminderTexts.fromSettings(settings);
      final planned = planReminders(
        shifts: shifts,
        events: events,
        templates: ref.read(templatesByIdProvider),
        now: now,
        limit: maxScheduled,
      );

      await notifier.replaceAll(
        [
          for (final (index, reminder) in planned.indexed)
            ScheduledReminder(
              id: index,
              at: reminder.at,
              title: texts.title(reminder),
              body: texts.body(reminder, now),
              dayKey: dayKey(reminder.day),
            ),
        ],
        channelName: texts.channelName,
      );
      talker.info('Reminders scheduled: ${planned.length}');
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Reminders sync failed');
    }
  }
}
