import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/section_label.dart';
import '../../../l10n/app_localizations.dart';

class PaySectionLabel extends StatelessWidget {
  const PaySectionLabel({required this.earned, required this.currency, super.key});

  final int earned;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return SectionLabel(
      AppLocalizations.of(context).pay,
      trailing: earned > 0
          ? Text(
              formatMoney(context, earned, currency),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: context.palette.text),
            )
          : null,
    );
  }
}
