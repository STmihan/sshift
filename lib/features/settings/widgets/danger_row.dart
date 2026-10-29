import 'package:flutter/material.dart';

import '../../../core/theme/dimensions.dart';
import '../../../core/theme/theme_context.dart';

class DangerRow extends StatelessWidget {
  const DangerRow({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(horizontal: rowInset),
        alignment: Alignment.centerLeft,
        child: Text(label, style: TextStyle(fontSize: 15, color: context.palette.danger)),
      ),
    );
  }
}
