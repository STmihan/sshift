import 'package:flutter/material.dart';

import '../../theme/theme_context.dart';

class MonthCell extends StatelessWidget {
  const MonthCell({
    required this.label,
    required this.selected,
    required this.current,
    required this.onTap,
    this.onLongPress,
    super.key,
  });

  final String label;
  final bool selected;
  final bool current;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Material(
      color: selected ? p.accent : p.background,
      shape: StadiumBorder(
        side: current && !selected ? BorderSide(color: p.accent, width: 1.5) : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: selected || current ? FontWeight.w700 : FontWeight.w500,
              color: selected ? p.onAccent : p.text,
            ),
          ),
        ),
      ),
    );
  }
}
