import 'package:flutter/material.dart';

import '../../../core/theme/theme_context.dart';

class ExternalLinkIcon extends StatelessWidget {
  const ExternalLinkIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Icon(Icons.open_in_new_rounded, color: context.palette.textSecondary, size: 18),
    );
  }
}
