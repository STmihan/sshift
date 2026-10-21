String formatAmountInput(int minor) {
  if (minor % 100 == 0) {
    return '${minor ~/ 100}';
  }

  return (minor / 100).toStringAsFixed(2).replaceFirst(RegExp(r'0$'), '');
}

int? parseAmount(String input) {
  final cleaned = input.replaceAll(RegExp(r'\s'), '').replaceAll(',', '.');

  if (cleaned.isEmpty) {
    return null;
  }

  final value = double.tryParse(cleaned);

  if (value == null || value < 0) {
    return null;
  }

  return (value * 100).round();
}
