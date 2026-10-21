import 'package:flutter/material.dart';

import '../theme/dimensions.dart';
import '../theme/theme_context.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({required this.children, this.padding = EdgeInsets.zero, super.key});

  final List<Widget> children;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final indent = padding == EdgeInsets.zero ? rowInset : 0.0;

    return Material(
      color: p.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: p.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) Divider(height: 1, thickness: 1, indent: indent, endIndent: indent, color: p.divider),
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}
