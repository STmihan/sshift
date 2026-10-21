import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/app_localizations.dart';
import '../../theme/theme_context.dart';
import '../../utils/dates.dart';
import '../../utils/formatters.dart';
import '../circle_button.dart';
import '../group_card.dart';
import '../pill_button.dart';
import '../sheet_header.dart';
import 'month_cell.dart';

class MonthPickerSheet extends StatefulWidget {
  const MonthPickerSheet({required this.initial, required this.multiple, super.key});

  final Set<DateTime> initial;
  final bool multiple;

  @override
  State<MonthPickerSheet> createState() {
    return _MonthPickerSheetState();
  }
}

class _MonthPickerSheetState extends State<MonthPickerSheet> {
  late Set<DateTime> _selection = {...widget.initial};
  late int _year = _selection.reduce((a, b) => a.isAfter(b) ? a : b).year;

  bool get _changed => _selection.length != widget.initial.length || !_selection.containsAll(widget.initial);

  void _toggle(DateTime month) {
    if (_selection.contains(month) && _selection.length == 1) {
      return;
    }

    HapticFeedback.selectionClick();
    setState(() {
      _selection = {..._selection};

      if (!_selection.remove(month)) {
        _selection.add(month);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final now = monthStart(DateTime.now());

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetHeader(l.pickMonth),
            GroupCard(
              padding: const EdgeInsets.all(12),
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        CircleButton(
                          icon: Icons.chevron_left_rounded,
                          size: 38,
                          onTap: () => setState(() => _year--),
                        ),
                        Expanded(
                          child: Text(
                            '$_year',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: p.text),
                          ),
                        ),
                        CircleButton(
                          icon: Icons.chevron_right_rounded,
                          size: 38,
                          onTap: () => setState(() => _year++),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.4,
                      children: [
                        for (var m = 1; m <= 12; m++)
                          MonthCell(
                            label: formatMonthShort(context, DateTime(_year, m)),
                            selected: _selection.contains(DateTime(_year, m)),
                            current: DateTime(_year, m) == now,
                            onTap: () => Navigator.of(context).pop({DateTime(_year, m)}),
                            onLongPress: widget.multiple ? () => _toggle(DateTime(_year, m)) : null,
                          ),
                      ],
                    ),
                    if (widget.multiple) ...[
                      const SizedBox(height: 10),
                      Text(l.reportsMultiHint, style: TextStyle(fontSize: 11, color: p.textSecondary)),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PillButton(
                    label: l.today,
                    filled: false,
                    icon: Icons.today_rounded,
                    onTap: () => Navigator.of(context).pop({now}),
                  ),
                ),
                if (widget.multiple && _changed) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: PillButton(
                      label: l.doneCount(_selection.length),
                      onTap: () => Navigator.of(context).pop(_selection),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
