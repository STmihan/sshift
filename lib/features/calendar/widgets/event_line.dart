import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';
import '../../../domain/models/calendar_event.dart';

class EventLine extends StatelessWidget {
  const EventLine({required this.event, required this.onDark, super.key});

  final CalendarEvent event;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: p.event, shape: BoxShape.circle),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              event.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: onDark ? p.onAccent : p.text),
            ),
          ),
        ],
      ),
    );
  }
}
