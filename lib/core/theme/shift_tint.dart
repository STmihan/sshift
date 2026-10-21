import 'package:flutter/material.dart';

import 'palette.dart';

@immutable
class ShiftTint {
  factory ShiftTint(int base, Palette palette, Brightness brightness) {
    final color = Color(base);
    final light = brightness == Brightness.light;

    return ShiftTint._(
      strong: Color.lerp(palette.card, color, light ? 0.28 : 0.55)!,
      soft: Color.lerp(palette.card, color, light ? 0.10 : 0.25)!,
      text: Color.lerp(palette.text, color, light ? 0.75 : 0.25)!,
    );
  }

  const ShiftTint._({required this.strong, required this.soft, required this.text});

  final Color strong;
  final Color soft;
  final Color text;
}
