import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/data/database/app_database.dart';
import 'package:sshift/data/repositories/drift_attachments_repository.dart';
import 'package:sshift/data/repositories/drift_templates_repository.dart';
import 'package:sshift/domain/models/shift_template.dart';

void main() {
  late AppDatabase db;
  late DriftTemplatesRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    final attachments = DriftAttachmentsRepository(db, root: () => Directory.systemTemp.createTemp('attachments'));

    repository = DriftTemplatesRepository(db, attachments);
  });

  tearDown(() => db.close());

  test('reorder stores the new order', () async {
    for (final (index, title) in ['Day', 'Night', 'Evening'].indexed) {
      await repository.upsert(
        ShiftTemplate(id: title, title: title, icon: title[0], color: 0, sortOrder: index, updatedAt: DateTime(2026)),
      );
    }

    await repository.reorder(['Evening', 'Day', 'Night']);

    final templates = await repository.watchAll().first;

    expect(templates.map((t) => t.id), ['Evening', 'Day', 'Night']);
    expect(templates.map((t) => t.sortOrder), [0, 1, 2]);
  });
}
