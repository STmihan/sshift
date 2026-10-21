import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  ArrowPainter({required this.color, required this.pointsDown});

  final Color color;
  final bool pointsDown;

  @override
  void paint(Canvas canvas, Size size) {
    final path = pointsDown
        ? (Path()
            ..moveTo(0, 0)
            ..lineTo(size.width, 0)
            ..lineTo(size.width / 2, size.height))
        : (Path()
            ..moveTo(0, size.height)
            ..lineTo(size.width, size.height)
            ..lineTo(size.width / 2, 0));

    canvas.drawPath(path..close(), Paint()..color = color);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.pointsDown != pointsDown;
  }
}
