import '../models/backup_import_mode.dart';
import '../models/backup_info.dart';
import '../models/backup_stats.dart';

abstract interface class BackupRepository {
  Future<BackupStats> currentStats();

  Future<String> export({required bool includeAttachments, required String appVersion});

  Future<BackupInfo> inspect(String path);

  Future<BackupStats> restore(String path, BackupImportMode mode);

  Future<void> deleteAll();
}
