import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class Chevron extends StatelessWidget {
  const Chevron({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Icon(Icons.chevron_right_rounded, color: context.palette.textSecondary, size: 20),
    );
  }
}
