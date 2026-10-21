import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/dimensions.dart';
import '../../features/calendar/state/paint_mode_controller.dart';
import 'nav_bar.dart';
import 'nav_bar_metrics.dart';

class AppShell extends ConsumerWidget {
  const AppShell({required this.shell, super.key});

  static const _hiddenOffset = -120.0;

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final painting = ref.watch(paintModeProvider) != null;
    final bottom = MediaQuery.paddingOf(context).bottom;

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
