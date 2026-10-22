import 'dart:ui';

import 'package:intl/intl.dart';

import '../../core/utils/dates.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/models/time_format.dart';
import '../../l10n/app_localizations.dart';
import 'pending_reminder.dart';

class ReminderTexts {
  ReminderTexts._(this._l, this._locale, this._use24h);

  factory ReminderTexts.fromSettings(AppSettings settings) {
    final system = PlatformDispatcher.instance;
    final requested = settings.languageCode ?? system.locale.languageCode;
    final supported = AppLocalizations.supportedLocales.any((locale) => locale.languageCode == requested);
    final language = supported ? requested : _fallbackLanguage;
    final use24h = switch (settings.timeFormat) {
      TimeFormat.hours24 => true,
      TimeFormat.hours12 => false,
      TimeFormat.system => system.alwaysUse24HourFormat || language != _fallbackLanguage,
    };

    return ReminderTexts._(lookupAppLocalizations(Locale(language)), language, use24h);
  }

  static const _fallbackLanguage = 'en';

  final AppLocalizations _l;
  final String _locale;
  final bool _use24h;

  String get channelName => _l.remindersChannel;

  String title(PendingReminder reminder) {
    final title = reminder.title;

    return title == null || title.isEmpty ? _l.shift : title;
  }

  String body(PendingReminder reminder, DateTime now) {
    final span = reminder.allDay ? _l.allDay : '${_time(reminder.startMinute)} – ${_time(reminder.endMinute)}';
    final daysAway = dateOnly(reminder.day).difference(dateOnly(now)).inDays;

    return switch (daysAway) {
      0 => _l.reminderToday(span),
      1 => _l.reminderTomorrow(span),
      _ => _l.reminderOnDate(_date(reminder.day), span),
    };
  }

  String _time(int minute) {
    final pattern = _use24h ? 'HH:mm' : 'h:mm a';

    return DateFormat(pattern, _locale).format(DateTime(2000, 1, 1, 0, minute));
  }

  String _date(DateTime day) {
    final text = DateFormat.MMMEd(_locale).format(day);

    return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
  }
}
