import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/widgets/group_card.dart';
import '../../../l10n/app_localizations.dart';
import '../model/month_report.dart';
import 'chart_bar.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({
    required this.reports,
    required this.selected,
    required this.onSelect,
    required this.onToggle,
    super.key,
  });

  static const _barHeight = 96.0;

  final List<MonthReport> reports;
  final Set<DateTime> selected;
  final ValueChanged<DateTime> onSelect;
  final ValueChanged<DateTime> onToggle;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final maxEarned = reports.map((r) => r.earned).fold(0, math.max);

    return GroupCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.lastMonths,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: p.textSecondary),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final report in reports)
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onSelect(report.month),
                      onLongPress: () => onToggle(report.month),
                      child: ChartBar(
                        month: report.month,
                        selected: selected.contains(report.month),
                        fraction: maxEarned == 0 ? 0 : report.earned / maxEarned,
                        height: _barHeight,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(l.reportsMultiHint, style: TextStyle(fontSize: 11, color: p.textSecondary)),
          ],
        ),
      ],
    );
  }
}
