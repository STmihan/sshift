import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    required this.month,
    required this.selected,
    required this.fraction,
    required this.height,
    super.key,
  });

  static const _minBarHeight = 4.0;

  final DateTime month;
  final bool selected;
  final double fraction;
  final double height;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                height: math.max(_minBarHeight, height * fraction),
                decoration: BoxDecoration(
                  color: selected ? p.accent : p.selected,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            formatMonthShort(context, month),
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              color: selected ? p.text : p.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
