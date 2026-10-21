import 'package:flutter/material.dart';

import '../theme/theme_context.dart';

class PillButton extends StatelessWidget {
  const PillButton({required this.label, required this.onTap, this.filled = true, this.icon, super.key});

  final String label;
  final VoidCallback? onTap;
  final bool filled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final background = filled ? p.accent : p.card;
    final foreground = filled ? p.onAccent : p.text;

    return Material(
      color: onTap == null ? background.withValues(alpha: 0.4) : background,
      shape: StadiumBorder(side: filled ? BorderSide.none : BorderSide(color: p.divider)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: foreground),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
