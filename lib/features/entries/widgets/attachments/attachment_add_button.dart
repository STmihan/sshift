import 'package:flutter/material.dart';

import '../../../../core/theme/theme_context.dart';

class AttachmentAddButton extends StatelessWidget {
  const AttachmentAddButton({required this.icon, required this.label, required this.onTap, super.key});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final foreground = onTap == null ? p.textMuted : p.text;

    return Material(
      color: p.background,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: foreground),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
