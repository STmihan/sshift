import 'package:flutter/material.dart';

import '../../../../core/theme/theme_context.dart';
import 'arrow_painter.dart';

class PopoverArrow extends StatelessWidget {
  const PopoverArrow({required this.pointsDown, super.key});

  static const size = Size(18, 9);

  final bool pointsDown;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: ArrowPainter(color: context.palette.popover, pointsDown: pointsDown),
    );
  }
}
