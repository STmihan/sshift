import 'package:flutter/material.dart';

import '../theme/dimensions.dart';
import '../theme/theme_context.dart';

class InlineTextField extends StatelessWidget {
  const InlineTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.textCapitalization = TextCapitalization.sentences,
    this.autofocus = false,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return TextField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      autofocus: autofocus,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
      style: TextStyle(fontSize: 15, color: p.text),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: p.textSecondary),
        border: InputBorder.none,
        counterText: '',
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: rowInset, vertical: 15),
      ),
    );
  }
}
