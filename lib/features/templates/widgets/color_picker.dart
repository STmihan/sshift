import 'package:flutter/material.dart';

import '../../../core/theme/shift_colors.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/widgets/group_card.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({required this.selected, required this.onChanged, super.key});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return GroupCard(
      padding: const EdgeInsets.all(12),
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 10,
          children: [
            for (final color in shiftColors)
              GestureDetector(
                onTap: () => onChanged(color),
                child: Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color == selected ? p.accent : Colors.transparent, width: 2),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: context.tint(color).strong, shape: BoxShape.circle),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
