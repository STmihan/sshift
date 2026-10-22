import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../theme/theme_context.dart';

class TimeWheel extends StatelessWidget {
  const TimeWheel({
    required this.labels,
    required this.controller,
    required this.onChanged,
    this.looping = true,
    super.key,
  });

  static const itemExtent = 44.0;

  final List<String> labels;
  final FixedExtentScrollController controller;
  final ValueChanged<int> onChanged;
  final bool looping;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return CupertinoPicker(
      scrollController: controller,
      itemExtent: itemExtent,
      looping: looping,
      selectionOverlay: null,
      onSelectedItemChanged: (index) {
        HapticFeedback.selectionClick();
        onChanged(index);
      },
      children: [
        for (final label in labels)
          Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: p.text),
            ),
          ),
      ],
    );
  }
}
