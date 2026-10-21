import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../core/theme/system_ui_style.dart';
import '../core/widgets/time_format_scope.dart';
import '../domain/models/time_format.dart';
import '../features/settings/settings_controller.dart';
import '../l10n/app_localizations.dart';
import 'router.dart';

class SShiftApp extends ConsumerWidget {
  const SShiftApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: settings.themeMode,
      locale: settings.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final media = MediaQuery.of(context);
        final use24h = switch (settings.timeFormat) {
          TimeFormat.system => media.alwaysUse24HourFormat,
          TimeFormat.hours24 => true,
          TimeFormat.hours12 => false,
        };

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiStyleFor(Theme.of(context).brightness),
          child: TimeFormatScope(
            format: settings.timeFormat,
            child: MediaQuery(
              data: media.copyWith(alwaysUse24HourFormat: use24h),
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
