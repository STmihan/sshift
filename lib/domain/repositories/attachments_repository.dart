import 'package:cross_file/cross_file.dart';

import '../models/attachment.dart';
import '../models/attachment_owner.dart';

abstract interface class AttachmentsRepository {
  Stream<List<Attachment>> watchFor(AttachmentOwner owner);

  Future<Attachment> add(AttachmentOwner owner, XFile file);

  Future<void> delete(Attachment attachment);

  Future<void> deleteForOwner(AttachmentOwner owner);

  Future<void> deleteOrphans({required DateTime createdBefore});

  Future<String> resolvePath(Attachment attachment);
}
