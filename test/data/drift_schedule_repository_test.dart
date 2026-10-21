import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/data/database/app_database.dart';
import 'package:sshift/data/repositories/drift_attachments_repository.dart';
import 'package:sshift/data/repositories/drift_schedule_repository.dart';
import 'package:sshift/domain/models/pay.dart';
import 'package:sshift/domain/models/pay_type.dart';

import '../helpers/fixtures.dart';

void main() {
  late AppDatabase db;
  late DriftScheduleRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    final attachments = DriftAttachmentsRepository(db, root: () => Directory.systemTemp.createTemp('attachments'));

    repository = DriftScheduleRepository(db, attachments);
  });

  tearDown(() => db.close());

  test('recentShiftPays returns distinct pays, newest first', () async {
    await repository.upsertShift(shiftOn(DateTime(2026, 10), pay: const Pay(PayType.fixed, 300000)));
    await repository.upsertShift(shiftOn(DateTime(2026, 10, 2), pay: const Pay(PayType.fixed, 350000)));
    await repository.upsertShift(shiftOn(DateTime(2026, 10, 3), pay: const Pay(PayType.fixed, 300000)));
    await repository.upsertShift(shiftOn(DateTime(2026, 10, 4)));
    await repository.upsertShift(
      shiftOn(DateTime(2026, 10, 5), templateId: 'other', pay: const Pay(PayType.fixed, 1)),
    );

    final pays = await repository.recentShiftPays('t1');

    expect(pays, [const Pay(PayType.fixed, 300000), const Pay(PayType.fixed, 350000)]);
  });

  test('getShifts filters by a half-open range', () async {
    await repository.upsertShift(shiftOn(DateTime(2026, 9, 30)));
    await repository.upsertShift(shiftOn(DateTime(2026, 10)));
    await repository.upsertShift(shiftOn(DateTime(2026, 11)));

    final shifts = await repository.getShifts(DateTime(2026, 10), DateTime(2026, 11));

    expect(shifts.map((s) => s.day), [DateTime(2026, 10)]);
  });
}
