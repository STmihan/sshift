import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class UpdateBadge extends StatelessWidget {
  const UpdateBadge({required this.version, super.key});

  final String version;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: p.accent, borderRadius: BorderRadius.circular(10)),
      child: Text(
        version,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: p.onAccent),
      ),
    );
  }
}
