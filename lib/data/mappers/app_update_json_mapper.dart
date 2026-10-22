import '../../domain/models/app_update.dart';

Map<String, Object?> appUpdateToJson(AppUpdate update) {
  return {
    'version': update.version,
    'notes': update.notes,
    'apkUrl': update.apkUrl,
    'apkSize': update.apkSize,
    'releaseUrl': update.releaseUrl,
  };
}

AppUpdate? appUpdateFromJson(Map<String, Object?> json) {
  final version = json['version'] as String?;
  final apkUrl = json['apkUrl'] as String?;

  if (version == null || apkUrl == null) {
    return null;
  }

  return AppUpdate(
    version: version,
    notes: json['notes'] as String? ?? '',
    apkUrl: apkUrl,
    apkSize: (json['apkSize'] as num?)?.toInt() ?? 0,
    releaseUrl: json['releaseUrl'] as String? ?? '',
  );
}
