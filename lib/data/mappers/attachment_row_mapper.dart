import '../../domain/models/attachment.dart';
import '../../domain/models/attachment_owner.dart';
import '../../domain/models/attachment_owner_type.dart';
import '../database/app_database.dart';

AttachmentOwner attachmentOwnerFromRow(AttachmentRow row) {
  return AttachmentOwner(AttachmentOwnerType.values.byName(row.ownerType), row.ownerId);
}

Attachment attachmentFromRow(AttachmentRow row) {
  return Attachment(
    id: row.id,
    owner: attachmentOwnerFromRow(row),
    name: row.name,
    path: row.path,
    size: row.size,
    createdAt: row.createdAt,
  );
}

AttachmentsCompanion attachmentToCompanion(Attachment a) {
  return AttachmentsCompanion.insert(
    id: a.id,
    ownerType: a.owner.type.name,
    ownerId: a.owner.id,
    name: a.name,
    path: a.path,
    size: a.size,
    createdAt: a.createdAt,
  );
}
