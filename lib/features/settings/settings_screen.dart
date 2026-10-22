import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/shell/nav_bar_metrics.dart';
import '../../core/app_links.dart';
import '../../core/app_version_provider.dart';
import '../../core/logger.dart';
import '../../core/theme/theme_context.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/open_link.dart';
import '../../core/widgets/centered_content.dart';
import '../../core/widgets/field_row.dart';
import '../../core/widgets/group_card.dart';
import '../../core/widgets/option_picker_sheet.dart';
import '../../core/widgets/page_header.dart';
import '../../core/widgets/switch_row.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/models/time_format.dart';
import '../../l10n/app_localizations.dart';
import '../updates/update_sheet.dart';
import '../updates/updates_controller.dart';
import '../updates/widgets/update_badge.dart';
import 'settings_controller.dart';
import 'widgets/chevron.dart';
import 'widgets/external_link_icon.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _followSystem = 'system';
  static const _languages = [_followSystem, 'ru', 'en'];
  static const _languageEndonyms = {'ru': 'Русский', 'en': 'English'};
  static const _systemWeekStart = -1;
  static const _weekStarts = [_systemWeekStart, DateTime.monday, DateTime.sunday % 7, DateTime.saturday];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final settings = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);
    final version = ref.watch(appVersionProvider).value;
    final updates = ref.watch(updatesControllerProvider);
    final available = updates.available;

    Future<void> checkForUpdates() async {
      final messenger = ScaffoldMessenger.of(context);
      final upToDate = l.upToDate;
      final failed = l.updateCheckFailed;

      try {
        final update = await ref.read(updatesControllerProvider.notifier).checkNow();

        if (!context.mounted) {
          return;
        }

        if (update == null) {
          messenger.showSnackBar(SnackBar(content: Text(upToDate)));

          return;
        }

        await showUpdateSheet(context, update);
      } on Exception catch (error, stack) {
        talker.handle(error, stack, 'Manual update check failed');
        messenger.showSnackBar(SnackBar(content: Text(failed)));
      }
    }

    String languageLabel(String code) {
      return code == _followSystem ? l.system : _languageEndonyms[code]!;
    }

    String themeLabel(ThemeMode mode) {
      return switch (mode) {
        ThemeMode.system => l.system,
        ThemeMode.light => l.themeLight,
        ThemeMode.dark => l.themeDark,
      };
    }

    String timeFormatLabel(TimeFormat format) {
      return switch (format) {
        TimeFormat.system => l.system,
        TimeFormat.hours24 => l.timeFormat24,
        TimeFormat.hours12 => l.timeFormat12,
      };
    }

    String weekStartLabel(int day) {
      return day == _systemWeekStart ? l.system : formatWeekdayName(context, day);
    }

    String currencyLabel(String code) {
      return '$code  ${currencySymbol(context, code)}';
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.only(bottom: navBarBottomReserve(context)),
          children: [
            PageHeader(title: l.settingsTitle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CenteredContent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GroupCard(
                      children: [
                        FieldRow(
                          label: l.language,
                          value: languageLabel(settings.languageCode ?? _followSystem),
                          trailing: const Chevron(),
                          onTap: () async {
                            final code = await showOptionPicker<String>(
                              context,
                              title: l.language,
                              options: _languages,
                              selected: settings.languageCode ?? _followSystem,
                              label: languageLabel,
                            );

                            if (code == null) {
                              return;
                            }

                            await controller.update(
                              (s) => s.copyWith(languageCode: () => code == _followSystem ? null : code),
                            );
                          },
                        ),
                        FieldRow(
                          label: l.theme,
                          value: themeLabel(settings.themeMode),
                          trailing: const Chevron(),
                          onTap: () async {
                            final mode = await showOptionPicker<ThemeMode>(
                              context,
                              title: l.theme,
                              options: ThemeMode.values,
                              selected: settings.themeMode,
                              label: themeLabel,
                            );

                            if (mode != null) {
                              await controller.update((s) => s.copyWith(themeMode: mode));
                            }
                          },
                        ),
                        FieldRow(
                          label: l.firstDayOfWeek,
                          value: weekStartLabel(settings.firstDayOfWeek ?? _systemWeekStart),
                          trailing: const Chevron(),
                          onTap: () async {
                            final day = await showOptionPicker<int>(
                              context,
                              title: l.firstDayOfWeek,
                              options: _weekStarts,
                              selected: settings.firstDayOfWeek ?? _systemWeekStart,
                              label: weekStartLabel,
                            );

                            if (day == null) {
                              return;
                            }

                            await controller.update(
                              (s) => s.copyWith(firstDayOfWeek: () => day == _systemWeekStart ? null : day),
                            );
                          },
                        ),
                        FieldRow(
                          label: l.timeFormat,
                          value: timeFormatLabel(settings.timeFormat),
                          trailing: const Chevron(),
                          onTap: () async {
                            final format = await showOptionPicker<TimeFormat>(
                              context,
                              title: l.timeFormat,
                              options: TimeFormat.values,
                              selected: settings.timeFormat,
                              label: timeFormatLabel,
                            );

                            if (format != null) {
                              await controller.update((s) => s.copyWith(timeFormat: format));
                            }
                          },
                        ),
                        FieldRow(
                          label: l.currency,
                          value: currencyLabel(settings.currency),
                          trailing: const Chevron(),
                          onTap: () async {
                            final currency = await showOptionPicker<String>(
                              context,
                              title: l.currency,
                              options: AppSettings.supportedCurrencies,
                              selected: settings.currency,
                              label: currencyLabel,
                            );

                            if (currency != null) {
                              await controller.update((s) => s.copyWith(currency: currency));
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GroupCard(
                      children: [
                        SwitchRow(
                          label: l.autoCheckUpdates,
                          value: settings.autoCheckUpdates,
                          onChanged: (value) {
                            unawaited(controller.update((s) => s.copyWith(autoCheckUpdates: value)));
                          },
                        ),
                        FieldRow(
                          label: l.checkForUpdates,
                          trailing: updates.checking
                              ? SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: p.textSecondary),
                                )
                              : available != null
                              ? UpdateBadge(version: available.version)
                              : const Chevron(),
                          onTap: updates.checking ? null : checkForUpdates,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GroupCard(
                      children: [
                        FieldRow(
                          label: l.logs,
                          trailing: const Chevron(),
                          onTap: () => context.push(Routes.logs),
                        ),
                        FieldRow(
                          label: githubName,
                          trailing: const ExternalLinkIcon(),
                          onTap: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final failedText = l.openLinkFailed;

                            if (!await openExternalLink(githubRepositoryUrl)) {
                              talker.warning('Failed to open $githubRepositoryUrl');
                              messenger.showSnackBar(SnackBar(content: Text(failedText)));
                            }
                          },
                        ),
                      ],
                    ),
                    if (version != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        l.appVersion(l.appTitle, version),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: p.textSecondary),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
