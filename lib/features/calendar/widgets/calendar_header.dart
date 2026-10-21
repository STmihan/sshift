import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/dates.dart';
import '../../../core/widgets/circle_button.dart';
import '../../../l10n/app_localizations.dart';
import 'month_title.dart';
import 'today_pill.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({required this.month, required this.onPickMonth, required this.onToday, super.key});

  final ValueListenable<DateTime> month;
  final VoidCallback onPickMonth;
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      child: ValueListenableBuilder<DateTime>(
        valueListenable: month,
        builder: (context, month, _) {
          final isCurrentMonth = month == monthStart(today());

          return Row(
            children: [
              CircleButton(icon: Icons.calendar_month_outlined, onTap: onPickMonth),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: onPickMonth,
                  child: MonthTitle(month: month),
                ),
              ),
              AnimatedOpacity(
                opacity: isCurrentMonth ? 0 : 1,
                duration: const Duration(milliseconds: 150),
                child: IgnorePointer(
                  ignoring: isCurrentMonth,
                  child: TodayPill(label: AppLocalizations.of(context).today, onTap: onToday),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
