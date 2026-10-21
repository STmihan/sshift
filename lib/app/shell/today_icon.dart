import 'package:flutter/material.dart';

import '../../core/theme/theme_context.dart';

class TodayIcon extends StatelessWidget {
  const TodayIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      width: 19,
      height: 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: p.accent, borderRadius: BorderRadius.circular(4)),
      child: Text(
        '${DateTime.now().day}',
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: p.onAccent, height: 1),
      ),
    );
  }
}
