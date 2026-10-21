import 'package:flutter/material.dart';

import '../theme/theme_context.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({required this.title, this.subtitle, this.trailing, super.key});

  final String title;
  final Widget? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: context.palette.text, height: 1.1),
                ),
                ?subtitle,
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
