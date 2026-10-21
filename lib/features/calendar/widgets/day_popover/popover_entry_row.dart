import 'package:flutter/material.dart';

import '../../../../core/theme/theme_context.dart';

class PopoverEntryRow extends StatelessWidget {
  const PopoverEntryRow({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
    super.key,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final String trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = context.palette.onPopover;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: foreground),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: foreground.withValues(alpha: 0.75))),
                ],
              ),
            ),
            Text(trailing, style: TextStyle(fontSize: 12, color: foreground.withValues(alpha: 0.85))),
          ],
        ),
      ),
    );
  }
}
