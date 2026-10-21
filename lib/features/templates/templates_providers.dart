import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_providers.dart';
import '../../domain/models/shift_template.dart';

final templatesProvider = StreamProvider<List<ShiftTemplate>>(
  (ref) => ref.watch(templatesRepositoryProvider).watchAll(),
);

final templatesByIdProvider = Provider<Map<String, ShiftTemplate>>((ref) {
  final templates = ref.watch(templatesProvider).value ?? const [];

  return {for (final t in templates) t.id: t};
});
