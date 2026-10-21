import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class RoundFab extends StatelessWidget {
  const RoundFab({required this.icon, required this.onTap, super.key});

  static const size = 32.0;

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Material(
      color: p.accent,
      shape: const CircleBorder(),
      elevation: 4,
      shadowColor: p.shadow.withValues(alpha: 0.4),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: 15, color: p.onAccent),
        ),
      ),
    );
  }
}
