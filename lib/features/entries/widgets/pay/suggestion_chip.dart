import 'package:flutter/material.dart';

import '../../../../core/theme/theme_context.dart';

class SuggestionChip extends StatelessWidget {
  const SuggestionChip({required this.label, required this.selected, required this.onTap, super.key});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Material(
      color: selected ? p.accent : p.background,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.history_rounded, size: 15, color: selected ? p.onAccent : p.textSecondary),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? p.onAccent : p.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
