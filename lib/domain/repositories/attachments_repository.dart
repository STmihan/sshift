import 'package:cross_file/cross_file.dart';

import '../models/attachment.dart';

abstract interface class AttachmentsRepository {
  Stream<List<Attachment>> watchForShift(String shiftId);

  Future<Attachment> add(String shiftId, XFile file);

  Future<void> delete(Attachment attachment);

  Future<String> resolvePath(Attachment attachment);
}
