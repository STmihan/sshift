import 'package:flutter/material.dart';

import '../theme/theme_context.dart';
import 'app_sheet.dart';
import 'field_row.dart';
import 'group_card.dart';
import 'sheet_header.dart';

Future<T?> showOptionPicker<T>(
  BuildContext context, {
  required String title,
  required List<T> options,
  required String Function(T) label,
  required T selected,
}) {
  return showAppSheet<T>(
    context,
    (_) => OptionPickerSheet<T>(title: title, options: options, label: label, selected: selected),
  );
}

class OptionPickerSheet<T> extends StatelessWidget {
  const OptionPickerSheet({
    required this.title,
    required this.options,
    required this.label,
    required this.selected,
    super.key,
  });

  final String title;
  final List<T> options;
  final String Function(T) label;
  final T selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetHeader(title),
            GroupCard(
              children: [
                for (final option in options)
                  FieldRow(
                    label: label(option),
                    onTap: () => Navigator.of(context).pop(option),
                    trailing: option == selected
                        ? Icon(Icons.check_rounded, color: context.palette.text, size: 20)
                        : null,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
