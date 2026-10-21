import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/amounts.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/group_card.dart';
import '../../../../core/widgets/pill_segments.dart';
import '../../../../domain/models/pay.dart';
import '../../../../domain/models/pay_type.dart';
import '../../../../l10n/app_localizations.dart';
import 'suggestion_chip.dart';

class PayEditor extends StatefulWidget {
  const PayEditor({
    required this.value,
    required this.onChanged,
    required this.workedMinutes,
    required this.currency,
    this.suggestions = const [],
    super.key,
  });

  final Pay value;
  final ValueChanged<Pay> onChanged;
  final int workedMinutes;
  final String currency;
  final List<Pay> suggestions;

  @override
  State<PayEditor> createState() {
    return _PayEditorState();
  }
}

class _PayEditorState extends State<PayEditor> {
  late final _amount = TextEditingController(text: _textFor(widget.value));

  static String _textFor(Pay pay) {
    return pay.isSet && pay.amount > 0 ? formatAmountInput(pay.amount) : '';
  }

  @override
  void didUpdateWidget(PayEditor oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value.isSet && (parseAmount(_amount.text) ?? 0) != widget.value.amount) {
      _amount.text = _textFor(widget.value);
    }
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  void _setType(PayType type) {
    widget.onChanged(Pay(type, type == PayType.none ? 0 : (parseAmount(_amount.text) ?? 0)));
  }

  String _payLabel(Pay pay) {
    final money = formatMoney(context, pay.amount, widget.currency);

    return pay.type == PayType.hourly ? AppLocalizations.of(context).payPerHour(money) : money;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final pay = widget.value;
    final hourly = pay.type == PayType.hourly;

    return GroupCard(
      padding: const EdgeInsets.all(12),
      children: [
        PillSegments<PayType>(
          values: PayType.values,
          labels: [l.payNone, l.payFixed, l.payHourly],
          selected: pay.type,
          onChanged: _setType,
        ),
        if (pay.isSet)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _amount,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\s]'))],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: p.text),
                  onChanged: (text) => widget.onChanged(Pay(pay.type, parseAmount(text) ?? 0)),
                  decoration: InputDecoration(
                    hintText: hourly ? l.payRate : l.payAmount,
                    hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: p.textSecondary),
                    prefixText: '${currencySymbol(context, widget.currency)} ',
                    prefixStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: p.textSecondary),
                    suffixText: hourly ? l.perHourSuffix : null,
                    suffixStyle: TextStyle(fontSize: 15, color: p.textSecondary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                if (hourly && pay.amount > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      l.payHourlyTotal(
                        formatDuration(context, widget.workedMinutes),
                        _payLabel(pay),
                        formatMoney(context, pay.totalFor(widget.workedMinutes), widget.currency),
                      ),
                      style: TextStyle(fontSize: 13, color: p.textSecondary),
                    ),
                  ),
              ],
            ),
          ),
        if (widget.suggestions.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.payFromPrevious, style: TextStyle(fontSize: 12, color: p.textSecondary)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final suggestion in widget.suggestions)
                      SuggestionChip(
                        label: _payLabel(suggestion),
                        selected: suggestion == pay,
                        onTap: () {
                          _amount.text = _textFor(suggestion);
                          widget.onChanged(suggestion);
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
