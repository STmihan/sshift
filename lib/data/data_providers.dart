import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repositories/attachments_repository.dart';
import '../domain/repositories/schedule_repository.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/repositories/templates_repository.dart';
import 'database/app_database.dart';
import 'repositories/drift_attachments_repository.dart';
import 'repositories/drift_schedule_repository.dart';
import 'repositories/drift_templates_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();

  ref.onDispose(db.close);

  return db;
});

final _driftAttachmentsProvider = Provider<DriftAttachmentsRepository>(
  (ref) => DriftAttachmentsRepository(ref.watch(databaseProvider)),
);

final attachmentsRepositoryProvider = Provider<AttachmentsRepository>(
  (ref) => ref.watch(_driftAttachmentsProvider),
);

final templatesRepositoryProvider = Provider<TemplatesRepository>(
  (ref) => DriftTemplatesRepository(ref.watch(databaseProvider), ref.watch(_driftAttachmentsProvider)),
);

final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => DriftScheduleRepository(ref.watch(databaseProvider), ref.watch(_driftAttachmentsProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => throw UnimplementedError('settingsRepositoryProvider must be overridden'),
);
