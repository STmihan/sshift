import 'package:flutter/material.dart';

import '../../../core/theme/dimensions.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/shift_avatar.dart';
import '../../../domain/models/shift_template.dart';

class TemplateTile extends StatelessWidget {
  const TemplateTile({required this.template, this.onTap, this.trailing, super.key});

  final ShiftTemplate template;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: rowInset, vertical: 12),
        child: Row(
          children: [
            ShiftAvatar(icon: template.icon, color: template.color, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(template.title, style: TextStyle(fontSize: 15, color: p.text)),
                  const SizedBox(height: 2),
                  Text(
                    '${formatSpan(context, template)} • ${formatDuration(context, template.workedMinutes)}',
                    style: TextStyle(fontSize: 12, color: p.textSecondary),
                  ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
