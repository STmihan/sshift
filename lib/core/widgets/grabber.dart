import 'package:flutter/material.dart';

import '../theme/theme_context.dart';

class Grabber extends StatelessWidget {
  const Grabber({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: color ?? context.palette.textMuted,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
