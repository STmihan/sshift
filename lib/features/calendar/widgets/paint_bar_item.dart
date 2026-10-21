import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class PaintBarItem extends StatelessWidget {
  const PaintBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final Widget icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = context.palette.onPopover;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
      child: Material(
        color: selected ? foreground.withValues(alpha: 0.14) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 76),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(height: 4),
                  Text(
                    label,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: foreground),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
