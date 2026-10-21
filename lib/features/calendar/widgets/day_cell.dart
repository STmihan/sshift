import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../domain/models/shift_template.dart';
import '../layout/day_item.dart';
import '../layout/day_item_kind.dart';
import '../layout/month_layout.dart';
import 'event_line.dart';
import 'shift_chip.dart';

class DayCell extends StatelessWidget {
  const DayCell({
    required this.day,
    required this.inMonth,
    required this.isToday,
    required this.isWeekend,
    required this.isSelected,
    required this.painting,
    required this.items,
    required this.templates,
    required this.onTap,
    super.key,
  });

  final DateTime day;
  final bool inMonth;
  final bool isToday;
  final bool isWeekend;
  final bool isSelected;
  final bool painting;
  final List<DayItem> items;
  final Map<String, ShiftTemplate> templates;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final highlight = isToday && !painting;
    final numberColor = highlight || isSelected ? p.onAccent : (isWeekend ? p.weekendText : p.text);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: dayNumberHeight,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected && !highlight ? p.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${day.day}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: highlight || isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: numberColor,
                ),
              ),
            ),
          ),
        ),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: itemGap),
            child: SizedBox(
              height: item.height,
              child: _buildItem(context, item, onDark: highlight),
            ),
          ),
      ],
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(1.5),
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        decoration: highlight ? BoxDecoration(color: p.accent, borderRadius: BorderRadius.circular(6)) : null,
        child: ClipRect(
          child: inMonth ? content : Opacity(opacity: 0.3, child: content),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, DayItem item, {required bool onDark}) {
    final p = context.palette;

    return switch (item.kind) {
      DayItemKind.fullShift => ShiftChip(shift: item.shift!, template: templates[item.shift!.templateId]),
      DayItemKind.shiftLine => ShiftChip(
        shift: item.shift!,
        template: templates[item.shift!.templateId],
        compact: true,
      ),
      DayItemKind.eventLine => EventLine(event: item.event!, onDark: onDark),
      DayItemKind.slot => DecoratedBox(
        decoration: BoxDecoration(
          color: p.card,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: p.divider),
        ),
      ),
      DayItemKind.more => Center(
        child: Text(
          '+${item.hiddenCount}',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: onDark ? p.onAccent : p.textSecondary),
        ),
      ),
    };
  }
}
