import '../database/app_database.dart';

class SettingsStore {
  SettingsStore._(this._db, this._values);

  static Future<SettingsStore> open(AppDatabase db) async {
    final rows = await db.select(db.settings).get();

    return SettingsStore._(db, {for (final row in rows) row.key: row.value});
  }

  final AppDatabase _db;
  final Map<String, String> _values;

  String? getString(String key) {
    return _values[key];
  }

  int? getInt(String key) {
    final value = _values[key];

    return value == null ? null : int.tryParse(value);
  }

  bool? getBool(String key) {
    return switch (_values[key]) {
      'true' => true,
      'false' => false,
      _ => null,
    };
  }

  Future<void> setString(String key, String value) async {
    _values[key] = value;
    await _db
        .into(_db.settings)
        .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value, updatedAt: DateTime.now()));
  }

  Future<void> setInt(String key, int value) {
    return setString(key, '$value');
  }

  Future<void> setBool(String key, {required bool value}) {
    return setString(key, '$value');
  }

  Future<void> remove(String key) async {
    _values.remove(key);
    await (_db.delete(_db.settings)..where((s) => s.key.equals(key))).go();
  }
}
