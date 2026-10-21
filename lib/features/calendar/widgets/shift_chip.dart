import 'package:flutter/material.dart';

import '../../../core/theme/shift_colors.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/models/shift.dart';
import '../../../domain/models/shift_template.dart';
import '../../../l10n/app_localizations.dart';
import '../layout/month_layout.dart';

class ShiftChip extends StatelessWidget {
  const ShiftChip({required this.shift, required this.template, this.compact = false, super.key});

  final Shift shift;
  final ShiftTemplate? template;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final tint = context.tint(template?.color ?? fallbackShiftColor);
    final style = TextStyle(fontSize: 9.5, height: 1, fontWeight: FontWeight.w500, color: tint.text);
    final icon = Container(
      height: lineHeight,
      color: tint.strong,
      alignment: Alignment.center,
      child: Text(template?.icon ?? '', maxLines: 1, style: style.copyWith(fontWeight: FontWeight.w600)),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: compact
          ? icon
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                icon,
                Container(
                  height: lineHeight,
                  color: tint.soft,
                  alignment: Alignment.center,
                  child: Text(
                    shift.allDay ? AppLocalizations.of(context).allDay : formatTimeCompact(context, shift.startMinute),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: style,
                  ),
                ),
              ],
            ),
    );
  }
}
