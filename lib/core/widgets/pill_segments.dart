import 'package:flutter/material.dart';

import '../theme/theme_context.dart';

class PillSegments<T> extends StatelessWidget {
  const PillSegments({
    required this.values,
    required this.labels,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<T> values;
  final List<String> labels;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: p.background, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          for (var i = 0; i < values.length; i++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(values[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: values[i] == selected ? p.accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: values[i] == selected ? p.onAccent : p.text,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
