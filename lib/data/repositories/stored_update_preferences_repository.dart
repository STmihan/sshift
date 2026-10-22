import 'dart:convert';

import '../../domain/models/app_update.dart';
import '../../domain/repositories/update_preferences_repository.dart';
import '../mappers/app_update_json_mapper.dart';
import '../settings/settings_store.dart';

class StoredUpdatePreferencesRepository implements UpdatePreferencesRepository {
  StoredUpdatePreferencesRepository(this._store);

  static const _lastCheckAt = 'updatesLastCheckAt';
  static const _skippedVersion = 'updatesSkippedVersion';
  static const _cachedUpdate = 'updatesCachedUpdate';

  final SettingsStore _store;

  @override
  DateTime? get lastCheckAt {
    final millis = _store.getInt(_lastCheckAt);

    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  @override
  String? get skippedVersion => _store.getString(_skippedVersion);

  @override
  AppUpdate? get cachedUpdate {
    final raw = _store.getString(_cachedUpdate);

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
    return _store.setInt(_lastCheckAt, time.millisecondsSinceEpoch);
  }

  @override
  Future<void> skipVersion(String version) {
    return _store.setString(_skippedVersion, version);
  }

  @override
  Future<void> cacheUpdate(AppUpdate? update) {
    if (update == null) {
      return _store.remove(_cachedUpdate);
    }

    return _store.setString(_cachedUpdate, jsonEncode(appUpdateToJson(update)));
  }
}
