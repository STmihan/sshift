import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/dimensions.dart';
import '../../../core/theme/shift_colors.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/group_card.dart';
import '../../../core/widgets/shift_avatar.dart';
import '../../../l10n/app_localizations.dart';
import '../../templates/templates_providers.dart';
import '../model/month_report.dart';
import 'breakdown_row.dart';

class BreakdownCard extends ConsumerWidget {
  const BreakdownCard({required this.report, required this.currency, super.key});

  final MonthReport report;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final templates = ref.watch(templatesByIdProvider);
    final total = math.max(1, report.earned);

    return GroupCard(
      padding: const EdgeInsets.symmetric(horizontal: rowInset),
      children: [
        for (final totals in report.templates)
          BreakdownRow(
            leading: ShiftAvatar(
              icon: templates[totals.templateId]?.icon ?? '',
              color: templates[totals.templateId]?.color ?? fallbackShiftColor,
              size: 32,
            ),
            title: templates[totals.templateId]?.title ?? l.shift,
            subtitle: l.shiftTotals(totals.count, formatDuration(context, totals.minutes)),
            amount: formatMoney(context, totals.earned, currency),
            share: totals.earned / total,
            barColor: context.tint(templates[totals.templateId]?.color ?? fallbackShiftColor).strong,
          ),
        if (report.eventCount > 0)
          BreakdownRow(
            leading: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: p.event.withValues(alpha: 0.15), shape: BoxShape.circle),
              child: Icon(Icons.event_rounded, size: 17, color: p.event),
            ),
            title: l.events,
            subtitle: l.eventsCount(report.eventCount),
            amount: formatMoney(context, report.eventEarned, currency),
            share: report.eventEarned / total,
            barColor: p.event.withValues(alpha: 0.5),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(l.earned, style: TextStyle(fontSize: 15, color: p.textSecondary)),
              ),
              Text(
                formatMoney(context, report.earned, currency),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: p.text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
