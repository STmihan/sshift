import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({required this.month, super.key});

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: formatMonth(context, month)),
          TextSpan(
            text: ' ${month.year}',
            style: TextStyle(fontWeight: FontWeight.w500, color: p.textSecondary),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: p.text),
    );
  }
}
