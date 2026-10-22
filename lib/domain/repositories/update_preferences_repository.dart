abstract interface class UpdatePreferencesRepository {
  DateTime? get lastCheckAt;

  String? get skippedVersion;

  Future<void> markChecked(DateTime time);

  Future<void> skipVersion(String version);
}
