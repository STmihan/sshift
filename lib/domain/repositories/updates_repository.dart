import '../models/app_update.dart';
import '../models/download_progress.dart';

abstract interface class UpdatesRepository {
  Future<AppUpdate?> fetchLatest();

  Stream<DownloadProgress> downloadApk(AppUpdate update);

  Future<String?> findDownloadedApk(AppUpdate update);

  Future<void> clearDownloads({AppUpdate? keep});
}
