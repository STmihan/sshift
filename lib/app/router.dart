import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../core/logger.dart';
import '../features/calendar/calendar_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/templates/template_editor_screen.dart';
import '../features/templates/templates_screen.dart';
import 'routes.dart';
import 'shell/app_shell.dart';

final _rootKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: Routes.calendar,
  observers: [TalkerRouteObserver(talker)],
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, _, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.calendar, builder: (_, _) => const CalendarScreen())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.reports, builder: (_, _) => const ReportsScreen())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.shifts, builder: (_, _) => const TemplatesScreen())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.settings, builder: (_, _) => const SettingsScreen())],
        ),
      ],
    ),
    GoRoute(
      path: Routes.newTemplate,
      parentNavigatorKey: _rootKey,
      builder: (_, _) => const TemplateEditorScreen(),
    ),
    GoRoute(
      path: Routes.template,
      parentNavigatorKey: _rootKey,
      builder: (_, state) => TemplateEditorScreen(templateId: state.pathParameters[Routes.templateIdParam]),
    ),
    GoRoute(
      path: Routes.logs,
      parentNavigatorKey: _rootKey,
      builder: (_, _) => TalkerScreen(talker: talker),
    ),
  ],
);
