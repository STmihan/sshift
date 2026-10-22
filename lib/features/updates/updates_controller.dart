import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_version_provider.dart';
import '../../core/logger.dart';
import '../../core/utils/versions.dart';
import '../../data/data_providers.dart';
import '../../domain/models/app_update.dart';
import '../settings/settings_controller.dart';
import 'updates_state.dart';

final updatesControllerProvider = NotifierProvider<UpdatesController, UpdatesState>(UpdatesController.new);

class UpdatesController extends Notifier<UpdatesState> {
  static const checkInterval = Duration(hours: 6);

  @override
  UpdatesState build() {
    return const UpdatesState();
  }

  Future<AppUpdate?> checkOnStartup() async {
    final preferences = ref.read(updatePreferencesRepositoryProvider);
    final lastCheckAt = preferences.lastCheckAt;

    try {
      await ref.read(updatesRepositoryProvider).clearDownloads();

      if (!ref.read(settingsProvider).autoCheckUpdates) {
        return null;
      }

      if (lastCheckAt != null && DateTime.now().difference(lastCheckAt) < checkInterval) {
        return null;
      }

      final update = await _check();

      return update?.version == preferences.skippedVersion ? null : update;
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Update check failed');

      return null;
    }
  }

  Future<AppUpdate?> checkNow() {
    return _check();
  }

  Future<void> skip(AppUpdate update) async {
    await ref.read(updatePreferencesRepositoryProvider).skipVersion(update.version);
    talker.info('Update ${update.version} skipped');
  }

  Future<AppUpdate?> _check() async {
    state = UpdatesState(available: state.available, checking: true);

    try {
      final current = await ref.read(appVersionProvider.future);
      final latest = await ref.read(updatesRepositoryProvider).fetchLatest();
      final update = latest != null && isNewerVersion(latest.version, current) ? latest : null;

      await ref.read(updatePreferencesRepositoryProvider).markChecked(DateTime.now());
      state = UpdatesState(available: update);
      talker.info('Update check: current $current, latest ${latest?.version}');

      return update;
    } on Exception {
      state = UpdatesState(available: state.available);
      rethrow;
    }
  }
}
