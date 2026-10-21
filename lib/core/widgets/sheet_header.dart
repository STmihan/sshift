import 'package:flutter/material.dart';

import 'grabber.dart';

class SheetHeader extends StatelessWidget {
  const SheetHeader(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Grabber(),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
          child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
