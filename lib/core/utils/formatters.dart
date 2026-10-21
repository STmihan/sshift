import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/time_format.dart';
import '../../domain/models/time_span.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/time_format_scope.dart';

String _locale(BuildContext context) {
  return Localizations.localeOf(context).toLanguageTag();
}

bool _uses24h(BuildContext context) {
  switch (TimeFormatScope.of(context)) {
    case TimeFormat.hours24:
      return true;
    case TimeFormat.hours12:
      return false;
    case TimeFormat.system:
      final localizations = MaterialLocalizations.of(context);
      final format = localizations.timeOfDayFormat(alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context));
      return hourFormat(of: format) != HourFormat.h;
  }
}

String _capitalize(String s) {
  return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

DateTime _at(int minute) {
  return DateTime(2000, 1, 1, minute ~/ 60 % 24, minute % 60);
}

DateTime _weekday(int weekday) {
  return DateTime(2023, 1, 1 + weekday);
}

String formatTime(BuildContext context, int minute) {
  final pattern = _uses24h(context) ? 'HH:mm' : 'h:mm a';

  return DateFormat(pattern, _locale(context)).format(_at(minute));
}

String formatTimeCompact(BuildContext context, int minute) {
  if (_uses24h(context)) {
    return DateFormat('HH:mm', _locale(context)).format(_at(minute));
  }

  final pattern = minute % 60 == 0 ? 'h a' : 'h:mm a';

  return DateFormat(pattern, _locale(context)).format(_at(minute));
}

String formatSpan(BuildContext context, TimeSpan span) {
  if (span.allDay) {
    return AppLocalizations.of(context).allDay;
  }

  return '${formatTime(context, span.startMinute)} - ${formatTime(context, span.endMinute)}';
}

String formatDuration(BuildContext context, int minutes) {
  final l = AppLocalizations.of(context);
  final h = minutes ~/ 60;
  final m = minutes % 60;

  if (h == 0) {
    return l.minutesShort(m);
  }

  if (m == 0) {
    return l.hoursShort(h);
  }

  return l.hoursMinutesShort(h, m);
}

String formatHours(BuildContext context, int minutes) {
  return NumberFormat('#,##0.#', _locale(context)).format(minutes / 60);
}

String formatMonth(BuildContext context, DateTime d) {
  return _capitalize(DateFormat.LLLL(_locale(context)).format(d));
}

String formatMonthYear(BuildContext context, DateTime d) {
  return _capitalize(DateFormat.yMMMM(_locale(context)).format(d));
}

String formatMonthShort(BuildContext context, DateTime d) {
  return _capitalize(DateFormat.LLL(_locale(context)).format(d)).replaceAll('.', '');
}

String formatDayHeader(BuildContext context, DateTime d) {
  return _capitalize(DateFormat.MMMEd(_locale(context)).format(d));
}

String formatWeekdayNarrow(BuildContext context, int weekday) {
  return DateFormat.EEEEE(_locale(context)).format(_weekday(weekday)).toUpperCase();
}

String formatWeekdayName(BuildContext context, int weekday) {
  return _capitalize(DateFormat.EEEE(_locale(context)).format(_weekday(weekday)));
}

String formatMoney(BuildContext context, int minor, String currency) {
  final format = NumberFormat.simpleCurrency(
    locale: _locale(context),
    name: currency,
    decimalDigits: minor % 100 == 0 ? 0 : 2,
  );

  return format.format(minor / 100);
}

String currencySymbol(BuildContext context, String currency) {
  return NumberFormat.simpleCurrency(locale: _locale(context), name: currency).currencySymbol;
}
