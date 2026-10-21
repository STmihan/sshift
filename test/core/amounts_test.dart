import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/core/utils/amounts.dart';

void main() {
  test('parseAmount reads user input into minor units', () {
    expect(parseAmount('3 500'), 350000);
    expect(parseAmount('12,5'), 1250);
    expect(parseAmount(''), isNull);
    expect(parseAmount('abc'), isNull);
  });

  test('formatAmountInput drops needless zeros', () {
    expect(formatAmountInput(350000), '3500');
    expect(formatAmountInput(1250), '12.5');
    expect(formatAmountInput(1205), '12.05');
  });
}
