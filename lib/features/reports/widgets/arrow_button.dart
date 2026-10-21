import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({required this.icon, required this.onTap, super.key});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 18,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 22, color: context.palette.textSecondary),
      ),
    );
  }
}
