import 'package:flutter/foundation.dart';

import '../../domain/models/backup_snapshot.dart';

@immutable
class BackupDocument {
  const BackupDocument({required this.appVersion, required this.exportedAt, required this.snapshot});

  static const format = 'sshift-backup';
  static const currentVersion = 1;

  final String appVersion;
  final DateTime exportedAt;
  final BackupSnapshot snapshot;
}
