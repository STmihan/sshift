import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/dates.dart';
import '../../state/selected_day_controller.dart';
import 'popover_arrow.dart';
import 'popover_bubble.dart';

Future<void> showDayPopover(BuildContext context, WidgetRef ref, DateTime day, Rect cell) async {
  final selection = ref.read(selectedDayProvider.notifier)..select(dayKey(day));

  await showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 160),
    pageBuilder: (_, _, _) => DayPopover(day: day, cell: cell),
    transitionBuilder: (_, animation, _, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(scale: Tween(begin: 0.96, end: 1.0).animate(curved), child: child),
      );
    },
  );
  selection.select(null);
}

class DayPopover extends StatelessWidget {
  const DayPopover({required this.day, required this.cell, super.key});

  static const _maxWidth = 340.0;
  static const _screenMargin = 8.0;
  static const _arrowInset = 16.0;
  static const _openAboveThreshold = 0.45;
  static const _dayNumberBottom = 28.0;
  static const _bottomReserve = 100.0;

  final DateTime day;
  final Rect cell;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;
    const arrow = PopoverArrow.size;
    final width = (size.width - 2 * _screenMargin).clamp(0.0, _maxWidth);
    final left = (cell.center.dx - width / 2).clamp(_screenMargin, size.width - width - _screenMargin);
    final above = cell.top > size.height * _openAboveThreshold;
    final anchorY = above ? cell.top : cell.top + _dayNumberBottom;
    final arrowLeft = (cell.center.dx - arrow.width / 2).clamp(
      left + _arrowInset,
      left + width - _arrowInset - arrow.width,
    );
    final bubble = PopoverBubble(day: day);

    return Stack(
      children: above
          ? [
              Positioned(
                left: left,
                width: width,
                bottom: size.height - anchorY + arrow.height,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: anchorY - arrow.height - media.padding.top - _screenMargin),
                  child: bubble,
                ),
              ),
              Positioned(
                left: arrowLeft,
                top: anchorY - arrow.height - 0.5,
                child: const PopoverArrow(pointsDown: true),
              ),
            ]
          : [
              Positioned(
                left: arrowLeft,
                top: anchorY + 0.5,
                child: const PopoverArrow(pointsDown: false),
              ),
              Positioned(
                left: left,
                width: width,
                top: anchorY + arrow.height,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: size.height - anchorY - arrow.height - _bottomReserve - media.padding.bottom,
                  ),
                  child: bubble,
                ),
              ),
            ],
    );
  }
}
