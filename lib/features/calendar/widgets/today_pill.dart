import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class TodayPill extends StatelessWidget {
  const TodayPill({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Material(
      color: p.card,
      shape: StadiumBorder(side: BorderSide(color: p.divider)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: p.text),
          ),
        ),
      ),
    );
  }
}
