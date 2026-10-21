import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/domain/models/pay.dart';
import 'package:sshift/domain/models/pay_type.dart';
import 'package:sshift/features/reports/model/month_report.dart';

import '../../helpers/fixtures.dart';

void main() {
  const fixed = Pay(PayType.fixed, 350000);
  final shifts = [
    shiftOn(DateTime(2026, 9, 29), pay: fixed),
    shiftOn(DateTime(2026, 10, 19), pay: fixed),
    shiftOn(DateTime(2026, 10, 20), pay: fixed),
    shiftOn(DateTime(2026, 10, 21)),
  ];

  test('single month aggregates only that month', () {
    final report = MonthReport.single(DateTime(2026, 10), shifts, const []);

    expect(report.earned, 700000);
    expect(report.shiftCount, 3);
    expect(report.unpaidCount, 1);
    expect(report.templates.single.count, 3);
  });

  test('combined report sums several months', () {
    final report = MonthReport.combined({DateTime(2026, 9), DateTime(2026, 10)}, shifts, const []);

    expect(report.earned, 1050000);
    expect(report.shiftCount, 4);
    expect(report.month, DateTime(2026, 10));
  });
}
