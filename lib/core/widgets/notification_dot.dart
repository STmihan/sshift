import 'package:flutter/material.dart';

import '../theme/theme_context.dart';

class NotificationDot extends StatelessWidget {
  const NotificationDot({this.size = 8, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: p.danger,
        shape: BoxShape.circle,
        border: Border.all(color: p.card, width: 1.5),
      ),
    );
  }
}
