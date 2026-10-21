import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class StatChip extends StatelessWidget {
  const StatChip({required this.icon, required this.text, super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: p.background, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: p.textSecondary),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: p.text),
          ),
        ],
      ),
    );
  }
}
