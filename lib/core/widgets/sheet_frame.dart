import 'package:flutter/material.dart';

import '../theme/theme_context.dart';

class SheetFrame extends StatelessWidget {
  const SheetFrame({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: (media.size.height - media.viewInsets.bottom) * 0.92),
        child: Material(
          color: context.palette.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      ),
    );
  }
}
