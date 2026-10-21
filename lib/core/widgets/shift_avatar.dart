import 'package:flutter/material.dart';

import '../theme/theme_context.dart';

class ShiftAvatar extends StatelessWidget {
  const ShiftAvatar({required this.icon, required this.color, this.size = 30, super.key});

  final String icon;
  final int color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final tint = context.tint(color);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: tint.strong, shape: BoxShape.circle),
      child: Text(
        icon,
        maxLines: 1,
        style: TextStyle(fontSize: size * 0.32, fontWeight: FontWeight.w700, color: tint.text),
      ),
    );
  }
}
