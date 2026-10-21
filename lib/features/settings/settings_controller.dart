import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logger.dart';
import '../../data/data_providers.dart';
import '../../domain/models/app_settings.dart';

final settingsProvider = NotifierProvider<SettingsController, AppSettings>(SettingsController.new);

class SettingsController extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    return ref.watch(settingsRepositoryProvider).load();
  }

  Future<void> update(AppSettings Function(AppSettings) change) async {
    state = change(state);
    await ref.read(settingsRepositoryProvider).save(state);
    talker.info(
      'Settings: lang=${state.languageCode} theme=${state.themeMode.name} '
      'currency=${state.currency} firstDay=${state.firstDayOfWeek} time=${state.timeFormat.name}',
    );
  }
}
