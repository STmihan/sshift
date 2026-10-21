import 'package:flutter/material.dart';

@immutable
class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.background,
    required this.card,
    required this.weekend,
    required this.weekendText,
    required this.divider,
    required this.text,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.onAccent,
    required this.selected,
    required this.popover,
    required this.onPopover,
    required this.event,
    required this.onEvent,
    required this.danger,
    required this.positive,
    required this.shadow,
    required this.barrier,
    required this.overlay,
    required this.onOverlay,
  });

  static const light = Palette(
    background: Color(0xFFF1F1F6),
    card: Color(0xFFFFFFFF),
    weekend: Color(0xFFFAFAFB),
    weekendText: Color(0xFFD0484E),
    divider: Color(0xFFE9E9EE),
    text: Color(0xFF111114),
    textSecondary: Color(0xFF7C7C84),
    textMuted: Color(0xFFC6C6CC),
    accent: Color(0xFF1C1C1E),
    onAccent: Color(0xFFFFFFFF),
    selected: Color(0xFFE6E6EB),
    popover: Color(0xFF232838),
    onPopover: Color(0xFFFFFFFF),
    event: Color(0xFF2196F3),
    onEvent: Color(0xFFFFFFFF),
    danger: Color(0xFFE5484D),
    positive: Color(0xFF2E9D6A),
    shadow: Color(0xFF000000),
    barrier: Color(0x59000000),
    overlay: Color(0x8C000000),
    onOverlay: Color(0xFFFFFFFF),
  );

  static const dark = Palette(
    background: Color(0xFF0E0E10),
    card: Color(0xFF1C1C1F),
    weekend: Color(0xFF232327),
    weekendText: Color(0xFFFF8A85),
    divider: Color(0xFF2C2C30),
    text: Color(0xFFF2F2F5),
    textSecondary: Color(0xFF9A9AA2),
    textMuted: Color(0xFF4A4A50),
    accent: Color(0xFFF2F2F5),
    onAccent: Color(0xFF111114),
    selected: Color(0xFF2E2E33),
    popover: Color(0xFF2A3044),
    onPopover: Color(0xFFFFFFFF),
    event: Color(0xFF42A5F5),
    onEvent: Color(0xFFFFFFFF),
    danger: Color(0xFFFF6369),
    positive: Color(0xFF4CC38A),
    shadow: Color(0xFF000000),
    barrier: Color(0x80000000),
    overlay: Color(0x8C000000),
    onOverlay: Color(0xFFFFFFFF),
  );

  final Color background;
  final Color card;
  final Color weekend;
  final Color weekendText;
  final Color divider;
  final Color text;
  final Color textSecondary;
  final Color textMuted;
  final Color accent;
  final Color onAccent;
  final Color selected;
  final Color popover;
  final Color onPopover;
  final Color event;
  final Color onEvent;
  final Color danger;
  final Color positive;
  final Color shadow;
  final Color barrier;
  final Color overlay;
  final Color onOverlay;

  @override
  Palette copyWith() {
    return this;
  }

  @override
  Palette lerp(Palette? other, double t) {
    if (other == null) {
      return this;
    }

    Color l(Color a, Color b) {
      return Color.lerp(a, b, t)!;
    }

    return Palette(
      background: l(background, other.background),
      card: l(card, other.card),
      weekend: l(weekend, other.weekend),
      weekendText: l(weekendText, other.weekendText),
      divider: l(divider, other.divider),
      text: l(text, other.text),
      textSecondary: l(textSecondary, other.textSecondary),
      textMuted: l(textMuted, other.textMuted),
      accent: l(accent, other.accent),
      onAccent: l(onAccent, other.onAccent),
      selected: l(selected, other.selected),
      popover: l(popover, other.popover),
      onPopover: l(onPopover, other.onPopover),
      event: l(event, other.event),
      onEvent: l(onEvent, other.onEvent),
      danger: l(danger, other.danger),
      positive: l(positive, other.positive),
      shadow: l(shadow, other.shadow),
      barrier: l(barrier, other.barrier),
      overlay: l(overlay, other.overlay),
      onOverlay: l(onOverlay, other.onOverlay),
    );
  }
}
