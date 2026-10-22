import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'app/app.dart';
import 'core/logger.dart';
import 'data/data_providers.dart';
import 'data/repositories/prefs_settings_repository.dart';
import 'data/repositories/prefs_update_preferences_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) => talker.handle(details.exception, details.stack, 'Flutter error');
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught error');
    return true;
  };

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await initializeDateFormatting();
  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: {...PrefsSettingsRepository.keys, ...PrefsUpdatePreferencesRepository.keys},
    ),
  );

  talker.info('App started');

  runApp(
    ProviderScope(
      observers: [
        TalkerRiverpodObserver(
          talker: talker,
          settings: const TalkerRiverpodLoggerSettings(printStateFullData: false),
        ),
      ],
      overrides: [
        settingsRepositoryProvider.overrideWithValue(PrefsSettingsRepository(prefs)),
        updatePreferencesRepositoryProvider.overrideWithValue(PrefsUpdatePreferencesRepository(prefs)),
      ],
      child: const SShiftApp(),
    ),
  );
}
