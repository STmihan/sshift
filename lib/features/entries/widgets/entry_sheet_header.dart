import 'package:flutter/material.dart';

import '../../../core/widgets/grabber.dart';

class EntrySheetHeader extends StatelessWidget {
  const EntrySheetHeader({
    required this.color,
    required this.foreground,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.badge,
    super.key,
  });

  final Color color;
  final Color foreground;
  final Widget leading;
  final String title;
  final String subtitle;
  final String badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
      child: Column(
        children: [
          Grabber(color: foreground.withValues(alpha: 0.3)),
          const SizedBox(height: 14),
          Row(
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: foreground),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle, style: TextStyle(fontSize: 13, color: foreground.withValues(alpha: 0.75))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: foreground.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: foreground),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
