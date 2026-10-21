import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/domain/models/pay.dart';
import 'package:sshift/domain/models/pay_type.dart';

import '../helpers/fixtures.dart';

void main() {
  test('overnight shift spans into the next day', () {
    final shift = shiftOn(DateTime(2026, 10), start: 22 * 60, end: 6 * 60, breakMinutes: 30);

    expect(shift.endsNextDay, isTrue);
    expect(shift.spanMinutes, 8 * 60);
    expect(shift.workedMinutes, 7 * 60 + 30);
  });

  test('hourly pay uses worked minutes', () {
    final shift = shiftOn(DateTime(2026, 10), pay: const Pay(PayType.hourly, 50000), breakMinutes: 60);

    expect(shift.earned, 50000 * 10);
  });

  test('fixed pay ignores duration', () {
    expect(const Pay(PayType.fixed, 350000).totalFor(1), 350000);
  });
}
