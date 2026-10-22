import 'package:flutter/foundation.dart';

import 'attachment_owner.dart';

@immutable
class Attachment {
  const Attachment({
    required this.id,
    required this.owner,
    required this.name,
    required this.path,
    required this.size,
    required this.createdAt,
  });

  static const maxPerOwner = 10;

  static const _imageExtensions = {'jpg', 'jpeg', 'png', 'gif', 'webp', 'heic', 'heif', 'bmp'};
  static const _videoExtensions = {'mp4', 'mov', 'm4v', '3gp', 'webm', 'mkv', 'avi'};

  final String id;
  final AttachmentOwner owner;
  final String name;
  final String path;
  final int size;
  final DateTime createdAt;

  String get extension {
    final dot = name.lastIndexOf('.');

    return dot < 0 ? '' : name.substring(dot + 1).toLowerCase();
  }

  bool get isImage => _imageExtensions.contains(extension);

  bool get isVideo => _videoExtensions.contains(extension);
}
