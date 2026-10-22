import 'package:flutter/material.dart';

import '../../domain/models/app_settings.dart';
import '../../domain/models/time_format.dart';
import '../../domain/repositories/settings_repository.dart';
import '../settings/settings_store.dart';

class StoredSettingsRepository implements SettingsRepository {
  StoredSettingsRepository(this._store);

  static const _language = 'language';
  static const _theme = 'theme';
  static const _currency = 'currency';
  static const _firstDay = 'firstDayOfWeek';
  static const _timeFormat = 'timeFormat';
  static const _autoCheckUpdates = 'autoCheckUpdates';
  static const _notificationsEnabled = 'notificationsEnabled';

  final SettingsStore _store;

  @override
  AppSettings load() {
    final theme = _store.getString(_theme);
    final currency = _store.getString(_currency);
    final timeFormat = _store.getString(_timeFormat);

    return AppSettings(
      languageCode: _store.getString(_language),
      themeMode: ThemeMode.values.firstWhere((m) => m.name == theme, orElse: () => ThemeMode.system),
      currency: AppSettings.supportedCurrencies.contains(currency) ? currency! : AppSettings.defaultCurrency,
      firstDayOfWeek: _store.getInt(_firstDay),
      timeFormat: TimeFormat.values.firstWhere((f) => f.name == timeFormat, orElse: () => TimeFormat.system),
      autoCheckUpdates: _store.getBool(_autoCheckUpdates) ?? true,
      notificationsEnabled: _store.getBool(_notificationsEnabled) ?? true,
    );
  }

  @override
  Future<void> save(AppSettings settings) async {
    final language = settings.languageCode;
    final firstDay = settings.firstDayOfWeek;

    await (language == null ? _store.remove(_language) : _store.setString(_language, language));
    await (firstDay == null ? _store.remove(_firstDay) : _store.setInt(_firstDay, firstDay));
    await _store.setString(_theme, settings.themeMode.name);
    await _store.setString(_currency, settings.currency);
    await _store.setString(_timeFormat, settings.timeFormat.name);
    await _store.setBool(_autoCheckUpdates, value: settings.autoCheckUpdates);
    await _store.setBool(_notificationsEnabled, value: settings.notificationsEnabled);
  }
}
