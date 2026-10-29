import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/data_providers.dart';
import '../../../domain/models/backup_stats.dart';

final backupStatsProvider = FutureProvider.autoDispose<BackupStats>((ref) {
  return ref.watch(backupRepositoryProvider).currentStats();
});
