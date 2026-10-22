import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/app_update.dart';
import '../../domain/repositories/update_preferences_repository.dart';
import '../mappers/app_update_json_mapper.dart';

class PrefsUpdatePreferencesRepository implements UpdatePreferencesRepository {
  PrefsUpdatePreferencesRepository(this._prefs);

  static const _lastCheckAt = 'updatesLastCheckAt';
  static const _skippedVersion = 'updatesSkippedVersion';
  static const _cachedUpdate = 'updatesCachedUpdate';
  static const keys = {_lastCheckAt, _skippedVersion, _cachedUpdate};

  final SharedPreferencesWithCache _prefs;

  @override
  DateTime? get lastCheckAt {
    final millis = _prefs.getInt(_lastCheckAt);

    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  @override
  String? get skippedVersion => _prefs.getString(_skippedVersion);

  @override
  AppUpdate? get cachedUpdate {
    final raw = _prefs.getString(_cachedUpdate);

    if (raw == null) {
      return null;
    }

    try {
      return appUpdateFromJson(jsonDecode(raw) as Map<String, Object?>);
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> markChecked(DateTime time) {
    return _prefs.setInt(_lastCheckAt, time.millisecondsSinceEpoch);
  }

  @override
  Future<void> skipVersion(String version) {
    return _prefs.setString(_skippedVersion, version);
  }

  @override
  Future<void> cacheUpdate(AppUpdate? update) {
    if (update == null) {
      return _prefs.remove(_cachedUpdate);
    }

    return _prefs.setString(_cachedUpdate, jsonEncode(appUpdateToJson(update)));
  }
}
