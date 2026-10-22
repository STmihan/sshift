import 'package:flutter/material.dart';

import '../../core/widgets/notification_dot.dart';

class BadgedIcon extends StatelessWidget {
  const BadgedIcon({required this.icon, required this.showBadge, super.key});

  final Widget icon;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (showBadge)
          const Positioned(
            top: -2,
            right: -4,
            child: NotificationDot(size: 10),
          ),
      ],
    );
  }
}
