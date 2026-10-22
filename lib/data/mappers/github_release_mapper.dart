import '../../domain/models/app_update.dart';

AppUpdate? appUpdateFromGithubRelease(Map<String, Object?> json) {
  final tag = json['tag_name'] as String?;
  final assets = json['assets'] as List<Object?>? ?? const [];
  final apk = assets
      .whereType<Map<String, Object?>>()
      .where((asset) => (asset['name'] as String? ?? '').toLowerCase().endsWith('.apk'))
      .firstOrNull;
  final apkUrl = apk?['browser_download_url'] as String?;

  if (tag == null || apk == null || apkUrl == null) {
    return null;
  }

  return AppUpdate(
    version: tag.startsWith('v') ? tag.substring(1) : tag,
    notes: json['body'] as String? ?? '',
    apkUrl: apkUrl,
    apkSize: (apk['size'] as num?)?.toInt() ?? 0,
    releaseUrl: json['html_url'] as String? ?? '',
  );
}
