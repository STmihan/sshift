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

    try {
      await _restoreCached();

      final lastCheckAt = preferences.lastCheckAt;
      final due = lastCheckAt == null || DateTime.now().difference(lastCheckAt) >= checkInterval;

      if (ref.read(settingsProvider).autoCheckUpdates && due) {
        await _check();
      }
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Update check failed');
    }

    final update = state.available;

    try {
      await ref.read(updatesRepositoryProvider).clearDownloads(keep: update);
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Update downloads cleanup failed');
    }

    return update == null || update.version == preferences.skippedVersion ? null : update;
  }

  Future<AppUpdate?> checkNow() {
    return _check();
  }

  Future<void> postpone(AppUpdate update) async {
    await ref.read(updatePreferencesRepositoryProvider).skipVersion(update.version);
    talker.info('Update ${update.version} postponed');
  }

  Future<void> _restoreCached() async {
    final cached = ref.read(updatePreferencesRepositoryProvider).cachedUpdate;
    final current = await ref.read(appVersionProvider.future);

    if (cached != null && isNewerVersion(cached.version, current)) {
      state = UpdatesState(available: cached);
    }
  }

  Future<AppUpdate?> _check() async {
    final preferences = ref.read(updatePreferencesRepositoryProvider);

    state = UpdatesState(available: state.available, checking: true);

    try {
      final current = await ref.read(appVersionProvider.future);
      final latest = await ref.read(updatesRepositoryProvider).fetchLatest();
      final update = latest != null && isNewerVersion(latest.version, current) ? latest : null;

      await preferences.markChecked(DateTime.now());
      await preferences.cacheUpdate(update);
      state = UpdatesState(available: update);
      talker.info('Update check: current $current, latest ${latest?.version}');

      return update;
    } on Exception {
      state = UpdatesState(available: state.available);
      rethrow;
    }
  }
}
