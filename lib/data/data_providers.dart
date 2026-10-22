import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repositories/attachments_repository.dart';
import '../domain/repositories/schedule_repository.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/repositories/templates_repository.dart';
import '../domain/repositories/update_preferences_repository.dart';
import '../domain/repositories/updates_repository.dart';
import '../domain/services/reminder_notifier.dart';
import 'database/app_database.dart';
import 'repositories/drift_attachments_repository.dart';
import 'repositories/drift_schedule_repository.dart';
import 'repositories/drift_templates_repository.dart';
import 'repositories/github_updates_repository.dart';
import 'repositories/stored_settings_repository.dart';
import 'repositories/stored_update_preferences_repository.dart';
import 'services/local_reminder_notifier.dart';
import 'settings/settings_store.dart';

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

final settingsStoreProvider = Provider<SettingsStore>(
  (ref) => throw UnimplementedError('settingsStoreProvider must be overridden'),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => StoredSettingsRepository(ref.watch(settingsStoreProvider)),
);

final updatesRepositoryProvider = Provider<UpdatesRepository>((ref) {
  return GithubUpdatesRepository();
});

final updatePreferencesRepositoryProvider = Provider<UpdatePreferencesRepository>((ref) {
  return StoredUpdatePreferencesRepository(ref.watch(settingsStoreProvider));
});

final reminderNotifierProvider = Provider<ReminderNotifier>((ref) {
  return LocalReminderNotifier();
});
