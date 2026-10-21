import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/group_card.dart';
import '../../../l10n/app_localizations.dart';
import '../model/month_report.dart';
import 'stat_chip.dart';

class TotalCard extends StatelessWidget {
  const TotalCard({required this.report, required this.previous, required this.currency, super.key});

  final MonthReport report;
  final MonthReport? previous;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final previousEarned = previous?.earned ?? 0;
    final delta = previousEarned > 0 && report.earned > 0 ? (report.earned - previousEarned) / previousEarned : null;
    final deltaColor = (delta ?? 0) >= 0 ? p.positive : p.danger;

    return GroupCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.earned, style: TextStyle(fontSize: 14, color: p.textSecondary)),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                formatMoney(context, report.earned, currency),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: p.text, height: 1.1),
              ),
            ),
            if (delta != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    delta >= 0 ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                    size: 15,
                    color: deltaColor,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    l.changeVsPrevMonth((delta.abs() * 100).round()),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: deltaColor),
                  ),
                ],
              ),
            ],
            if (report.isEmpty) ...[
              const SizedBox(height: 6),
              Text(l.reportEmpty, style: TextStyle(fontSize: 13, color: p.textSecondary)),
            ],
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                StatChip(icon: Icons.work_outline_rounded, text: l.shiftsCount(report.shiftCount)),
                StatChip(icon: Icons.schedule_rounded, text: l.hoursValue(formatHours(context, report.shiftMinutes))),
                if (report.eventCount > 0) StatChip(icon: Icons.event_rounded, text: l.eventsCount(report.eventCount)),
              ],
            ),
            if (report.unpaidCount > 0) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.info_outline_rounded, size: 15, color: p.textSecondary),
                  const SizedBox(width: 6),
                  Text(l.unpaidCount(report.unpaidCount), style: TextStyle(fontSize: 12, color: p.textSecondary)),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }
}
