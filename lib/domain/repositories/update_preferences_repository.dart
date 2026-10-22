import '../models/app_update.dart';

abstract interface class UpdatePreferencesRepository {
  DateTime? get lastCheckAt;

  String? get skippedVersion;

  AppUpdate? get cachedUpdate;

  Future<void> markChecked(DateTime time);

  Future<void> skipVersion(String version);

  Future<void> cacheUpdate(AppUpdate? update);
}
