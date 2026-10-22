import 'package:flutter/material.dart';

import 'time_format.dart';

@immutable
class AppSettings {
  const AppSettings({
    this.languageCode,
    this.themeMode = ThemeMode.system,
    this.currency = defaultCurrency,
    this.firstDayOfWeek,
    this.timeFormat = TimeFormat.system,
    this.autoCheckUpdates = true,
  });

  static const defaultCurrency = 'RUB';
  static const supportedCurrencies = ['RUB', 'USD', 'EUR', 'GBP', 'KZT', 'UAH', 'BYN', 'GEL', 'TRY', 'PHP'];

  final String? languageCode;
  final ThemeMode themeMode;
  final String currency;
  final int? firstDayOfWeek;
  final TimeFormat timeFormat;
  final bool autoCheckUpdates;

  Locale? get locale => languageCode == null ? null : Locale(languageCode!);

  AppSettings copyWith({
    String? Function()? languageCode,
    ThemeMode? themeMode,
    String? currency,
    int? Function()? firstDayOfWeek,
    TimeFormat? timeFormat,
    bool? autoCheckUpdates,
  }) {
    return AppSettings(
      languageCode: languageCode != null ? languageCode() : this.languageCode,
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
      firstDayOfWeek: firstDayOfWeek != null ? firstDayOfWeek() : this.firstDayOfWeek,
      timeFormat: timeFormat ?? this.timeFormat,
      autoCheckUpdates: autoCheckUpdates ?? this.autoCheckUpdates,
    );
  }
}
