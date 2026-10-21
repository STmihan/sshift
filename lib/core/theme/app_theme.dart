import 'package:flutter/material.dart';

import 'palette.dart';

ThemeData buildTheme(Brightness brightness) {
  final p = brightness == Brightness.light ? Palette.light : Palette.dark;
  final scheme = ColorScheme.fromSeed(seedColor: p.accent, brightness: brightness).copyWith(
    primary: p.accent,
    onPrimary: p.onAccent,
    surface: p.card,
    onSurface: p.text,
    error: p.danger,
  );

  return ThemeData(
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: p.background,
    canvasColor: p.background,
    dividerColor: p.divider,
    extensions: [p],
    splashFactory: InkSparkle.splashFactory,
    textTheme: Typography.material2021().englishLike
        .merge(brightness == Brightness.light ? Typography.blackMountainView : Typography.whiteMountainView)
        .apply(bodyColor: p.text, displayColor: p.text),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? p.onAccent : p.card),
      trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? p.accent : p.textMuted),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: p.accent, selectionHandleColor: p.accent),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      modalBarrierColor: p.barrier,
      elevation: 0,
    ),
    timePickerTheme: TimePickerThemeData(backgroundColor: p.card),
    dialogTheme: DialogThemeData(backgroundColor: p.card),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: p.accent,
      contentTextStyle: TextStyle(color: p.onAccent),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
