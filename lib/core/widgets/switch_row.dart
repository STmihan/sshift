import 'package:flutter/material.dart';

import 'field_row.dart';

class SwitchRow extends StatelessWidget {
  const SwitchRow({required this.label, required this.value, required this.onChanged, super.key});

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return FieldRow(
      label: label,
      onTap: () => onChanged(!value),
      trailing: SizedBox(
        height: 32,
        child: FittedBox(
          child: Switch(value: value, onChanged: onChanged),
        ),
      ),
    );
  }
}
