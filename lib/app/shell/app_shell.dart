import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/logger.dart';
import '../../core/theme/dimensions.dart';
import '../../core/utils/dates.dart';
import '../../data/data_providers.dart';
import '../../features/calendar/state/calendar_focus_controller.dart';
import '../../features/calendar/state/paint_mode_controller.dart';
import '../../features/reminders/reminder_sync.dart';
import '../../features/updates/update_sheet.dart';
import '../../features/updates/updates_controller.dart';
import '../router.dart';
import '../routes.dart';
import 'nav_bar.dart';
import 'nav_bar_metrics.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  ConsumerState<AppShell> createState() {
    return _AppShellState();
  }
}

class _AppShellState extends ConsumerState<AppShell> {
  static const _hiddenOffset = -120.0;

  final _startedAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    unawaited(ref.read(reminderNotifierProvider).initialize(onOpenDay: _openDay));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_checkForUpdates());
      unawaited(_deleteOrphanedAttachments());
    });
  }

  void _openDay(int dayKey) {
    ref.read(paintModeProvider.notifier).stop();
    appRouter.go(Routes.calendar);
    ref.read(calendarFocusProvider.notifier).focus(monthStart(fromDayKey(dayKey)));
  }

  Future<void> _deleteOrphanedAttachments() async {
    try {
      await ref.read(attachmentsRepositoryProvider).deleteOrphans(createdBefore: _startedAt);
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Orphaned attachments cleanup failed');
    }
  }

  Future<void> _checkForUpdates() async {
    final update = await ref.read(updatesControllerProvider.notifier).checkOnStartup();

    if (update != null && mounted) {
      await showUpdateSheet(context, update);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(reminderSyncProvider);
    final painting = ref.watch(paintModeProvider) != null;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final shell = widget.shell;
    final hasUpdate = ref.watch(updatesControllerProvider.select((s) => s.available != null));

    return Scaffold(
      body: Stack(
        children: [
          shell,
          AnimatedPositioned(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            left: 0,
            right: 0,
            bottom: painting ? _hiddenOffset : navBarBottomGap + bottom,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: contentMaxWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: navBarSideInset),
                  child: NavBar(
                    index: shell.currentIndex,
                    settingsBadge: hasUpdate,
                    onTap: (index) {
                      ref.read(paintModeProvider.notifier).stop();
                      shell.goBranch(index, initialLocation: index == shell.currentIndex);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
