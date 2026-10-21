import 'package:flutter/material.dart';

import '../theme/theme_context.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({required this.icon, required this.onTap, this.size = 40, this.color, super.key});

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Material(
      color: p.card,
      shape: CircleBorder(side: BorderSide(color: p.divider)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: size * 0.5, color: color ?? p.text),
        ),
      ),
    );
  }
}
