import 'package:flutter/material.dart';

import '../../core/theme/theme_context.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final Widget icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected ? p.selected : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: IconTheme(
          data: IconThemeData(color: p.text),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 22, child: Center(child: icon)),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: p.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
