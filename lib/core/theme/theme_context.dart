import 'package:flutter/material.dart';

import 'palette.dart';
import 'shift_tint.dart';

extension ThemeContext on BuildContext {
  Palette get palette => Theme.of(this).extension<Palette>()!;

  ShiftTint tint(int base) {
    return ShiftTint(base, palette, Theme.of(this).brightness);
  }
}
