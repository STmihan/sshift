import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/time_format.dart';
import '../../domain/models/time_span.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/time_format_scope.dart';

final _dateFormats = <(String, String), DateFormat>{};
final _numberFormats = <(String, String), NumberFormat>{};
final _currencyFormats = <(String, String, int), NumberFormat>{};

DateFormat _dateFormat(BuildContext context, String pattern) {
  final locale = _locale(context);

  return _dateFormats.putIfAbsent((pattern, locale), () => DateFormat(pattern, locale));
}

NumberFormat _currencyFormat(BuildContext context, String currency, int decimalDigits) {
  final locale = _locale(context);

  return _currencyFormats.putIfAbsent(
    (locale, currency, decimalDigits),
    () => NumberFormat.simpleCurrency(locale: locale, name: currency, decimalDigits: decimalDigits),
  );
}

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

  return _dateFormat(context, pattern).format(_at(minute));
}

String formatTimeCompact(BuildContext context, int minute) {
  if (_uses24h(context)) {
    return _dateFormat(context, 'HH:mm').format(_at(minute));
  }

  final pattern = minute % 60 == 0 ? 'h a' : 'h:mm a';

  return _dateFormat(context, pattern).format(_at(minute));
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
  final locale = _locale(context);

  return _numberFormats.putIfAbsent(('#,##0.#', locale), () => NumberFormat('#,##0.#', locale)).format(minutes / 60);
}

String formatMonth(BuildContext context, DateTime d) {
  return _capitalize(_dateFormat(context, 'LLLL').format(d));
}

String formatMonthYear(BuildContext context, DateTime d) {
  return _capitalize(_dateFormat(context, 'yMMMM').format(d));
}

String formatMonthShort(BuildContext context, DateTime d) {
  return _capitalize(_dateFormat(context, 'LLL').format(d)).replaceAll('.', '');
}

String formatDayHeader(BuildContext context, DateTime d) {
  return _capitalize(_dateFormat(context, 'MMMEd').format(d));
}

String formatWeekdayNarrow(BuildContext context, int weekday) {
  return _dateFormat(context, 'EEEEE').format(_weekday(weekday)).toUpperCase();
}

String formatWeekdayName(BuildContext context, int weekday) {
  return _capitalize(_dateFormat(context, 'EEEE').format(_weekday(weekday)));
}

String formatMoney(BuildContext context, int minor, String currency) {
  return _currencyFormat(context, currency, minor % 100 == 0 ? 0 : 2).format(minor / 100);
}

String currencySymbol(BuildContext context, String currency) {
  return _currencyFormat(context, currency, 2).currencySymbol;
}
