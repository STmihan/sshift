import 'package:flutter/foundation.dart';

import 'backup_stats.dart';

@immutable
class BackupInfo {
  const BackupInfo({required this.appVersion, required this.exportedAt, required this.stats});

  final String appVersion;
  final DateTime exportedAt;
  final BackupStats stats;
}
