import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/core/utils/dates.dart';
import 'package:sshift/features/schedule/day_range.dart';

void main() {
  test('monthGridRange covers only the weeks shown for the month', () {
    final range = monthGridRange(DateTime(2026, 10), DateTime.sunday % 7);

    expect(fromDayKey(range.from), DateTime(2026, 9, 27));
    expect(fromDayKey(range.to), DateTime(2026, 11));
  });
}
