import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class BreakdownRow extends StatelessWidget {
  const BreakdownRow({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.share,
    required this.barColor,
    super.key,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final String amount;
  final double share;
  final Color barColor;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title, style: TextStyle(fontSize: 15, color: p.text)),
                    ),
                    Text(
                      amount,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: p.text),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 12, color: p.textSecondary)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: share.clamp(0, 1),
                    minHeight: 5,
                    backgroundColor: p.background,
                    valueColor: AlwaysStoppedAnimation(barColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
