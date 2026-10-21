import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/app_settings.dart';
import '../../domain/models/time_format.dart';
import '../../domain/repositories/settings_repository.dart';

class PrefsSettingsRepository implements SettingsRepository {
  PrefsSettingsRepository(this._prefs);

  static const _language = 'language';
  static const _theme = 'theme';
  static const _currency = 'currency';
  static const _firstDay = 'firstDayOfWeek';
  static const _timeFormat = 'timeFormat';
  static const keys = {_language, _theme, _currency, _firstDay, _timeFormat};

  final SharedPreferencesWithCache _prefs;

  @override
  AppSettings load() {
    final theme = _prefs.getString(_theme);
    final currency = _prefs.getString(_currency);
    final timeFormat = _prefs.getString(_timeFormat);

    return AppSettings(
      languageCode: _prefs.getString(_language),
      themeMode: ThemeMode.values.firstWhere((m) => m.name == theme, orElse: () => ThemeMode.system),
      currency: AppSettings.supportedCurrencies.contains(currency) ? currency! : AppSettings.defaultCurrency,
      firstDayOfWeek: _prefs.getInt(_firstDay),
      timeFormat: TimeFormat.values.firstWhere((f) => f.name == timeFormat, orElse: () => TimeFormat.system),
    );
  }

  @override
  Future<void> save(AppSettings settings) async {
    final language = settings.languageCode;
    final firstDay = settings.firstDayOfWeek;

    await (language == null ? _prefs.remove(_language) : _prefs.setString(_language, language));
    await (firstDay == null ? _prefs.remove(_firstDay) : _prefs.setInt(_firstDay, firstDay));
    await _prefs.setString(_theme, settings.themeMode.name);
    await _prefs.setString(_currency, settings.currency);
    await _prefs.setString(_timeFormat, settings.timeFormat.name);
  }
}
