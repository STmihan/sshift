import 'package:flutter/material.dart';

import '../../core/theme/theme_context.dart';
import '../../l10n/app_localizations.dart';
import 'badged_icon.dart';
import 'nav_bar_item.dart';
import 'nav_bar_metrics.dart';
import 'today_icon.dart';

class NavBar extends StatelessWidget {
  const NavBar({required this.index, required this.onTap, this.settingsBadge = false, super.key});

  final int index;
  final ValueChanged<int> onTap;
  final bool settingsBadge;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final items = [
      (const TodayIcon(), l.navCalendar),
      (const Icon(Icons.bar_chart_rounded, size: 22), l.navReports),
      (const Icon(Icons.view_agenda_outlined, size: 20), l.navShifts),
      (
        BadgedIcon(
          icon: const Icon(Icons.settings_rounded, size: 21),
          showBadge: settingsBadge,
        ),
        l.navSettings,
      ),
    ];

    return Container(
      height: navBarHeight,
      padding: const EdgeInsets.all(navBarPadding),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: p.divider),
        boxShadow: [
          BoxShadow(color: p.shadow.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              child: NavBarItem(
                icon: items[i].$1,
                label: items[i].$2,
                selected: i == index,
                onTap: () => onTap(i),
              ),
            ),
        ],
      ),
    );
  }
}
