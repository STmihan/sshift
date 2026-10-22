import 'package:flutter/foundation.dart';

import 'attachment_owner_type.dart';

@immutable
class AttachmentOwner {
  const AttachmentOwner(this.type, this.id);

  const AttachmentOwner.shift(this.id) : type = AttachmentOwnerType.shift;

  const AttachmentOwner.event(this.id) : type = AttachmentOwnerType.event;

  final AttachmentOwnerType type;
  final String id;

  @override
  bool operator ==(Object other) {
    return other is AttachmentOwner && other.type == type && other.id == id;
  }

  @override
  int get hashCode => Object.hash(type, id);

  @override
  String toString() {
    return '${type.name} $id';
  }
}
