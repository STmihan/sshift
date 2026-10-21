import 'package:flutter/material.dart';

import '../../../../core/theme/theme_context.dart';

class PopoverAddButton extends StatelessWidget {
  const PopoverAddButton({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = context.palette.onPopover.withValues(alpha: 0.6);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.add_rounded, size: 20, color: foreground),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 14, color: foreground)),
          ],
        ),
      ),
    );
  }
}
