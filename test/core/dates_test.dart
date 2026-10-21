import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/core/utils/dates.dart';

void main() {
  test('gridStart honors the first day of week', () {
    expect(gridStart(DateTime(2026, 10), DateTime.sunday % 7), DateTime(2026, 9, 27));
    expect(gridStart(DateTime(2026, 10), DateTime.monday), DateTime(2026, 9, 28));
  });

  test('weeksInMonth counts only weeks with days of the month', () {
    expect(weeksInMonth(DateTime(2026, 2), DateTime.sunday % 7), 4);
    expect(weeksInMonth(DateTime(2026, 10), DateTime.sunday % 7), 5);
    expect(weeksInMonth(DateTime(2026, 8), DateTime.sunday % 7), 6);
  });
}
