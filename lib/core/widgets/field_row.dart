import 'package:flutter/material.dart';

import '../theme/dimensions.dart';
import '../theme/theme_context.dart';

class FieldRow extends StatelessWidget {
  const FieldRow({required this.label, this.value, this.trailing, this.onTap, super.key});

  final String label;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(horizontal: rowInset),
        child: Row(
          children: [
            Expanded(
              child: Text(label, style: TextStyle(fontSize: 15, color: p.textSecondary)),
            ),
            if (value != null)
              Flexible(
                child: Text(
                  value!,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, color: p.text),
                ),
              ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
