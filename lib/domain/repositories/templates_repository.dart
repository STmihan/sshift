import '../models/shift_template.dart';

abstract interface class TemplatesRepository {
  Stream<List<ShiftTemplate>> watchAll();

  Future<void> upsert(ShiftTemplate template);

  Future<void> reorder(List<String> orderedIds);

  Future<void> delete(String id);
}
