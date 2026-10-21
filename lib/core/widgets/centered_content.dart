import 'package:flutter/material.dart';

import '../theme/dimensions.dart';

class CenteredContent extends StatelessWidget {
  const CenteredContent({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: contentMaxWidth),
        child: child,
      ),
    );
  }
}
