import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/update_preferences_repository.dart';

class PrefsUpdatePreferencesRepository implements UpdatePreferencesRepository {
  PrefsUpdatePreferencesRepository(this._prefs);

  static const _lastCheckAt = 'updatesLastCheckAt';
  static const _skippedVersion = 'updatesSkippedVersion';
  static const keys = {_lastCheckAt, _skippedVersion};

  final SharedPreferencesWithCache _prefs;

  @override
  DateTime? get lastCheckAt {
    final millis = _prefs.getInt(_lastCheckAt);

    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  @override
  String? get skippedVersion => _prefs.getString(_skippedVersion);

  @override
  Future<void> markChecked(DateTime time) {
    return _prefs.setInt(_lastCheckAt, time.millisecondsSinceEpoch);
  }

  @override
  Future<void> skipVersion(String version) {
    return _prefs.setString(_skippedVersion, version);
  }
}
