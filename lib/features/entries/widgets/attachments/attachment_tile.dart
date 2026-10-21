import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme_context.dart';
import '../../../../data/data_providers.dart';
import '../../../../domain/models/attachment.dart';
import 'attachment_file_face.dart';

class AttachmentTile extends ConsumerWidget {
  const AttachmentTile({required this.attachment, required this.onTap, required this.onDelete, super.key});

  static const size = 74.0;
  static const _thumbnailCacheWidth = 220;

  final Attachment attachment;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final face = AttachmentFileFace(attachment: attachment);
    final body = attachment.isImage
        ? FutureBuilder<String>(
            future: ref.read(attachmentsRepositoryProvider).resolvePath(attachment),
            builder: (_, snapshot) => snapshot.hasData
                ? Image.file(
                    File(snapshot.data!),
                    fit: BoxFit.cover,
                    cacheWidth: _thumbnailCacheWidth,
                    errorBuilder: (_, _, _) => face,
                  )
                : const SizedBox.shrink(),
          )
        : face;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: p.background,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: InkWell(onTap: onTap, onLongPress: onDelete, child: body),
            ),
          ),
          Positioned(
            top: 3,
            right: 3,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(color: p.overlay, shape: BoxShape.circle),
                child: Icon(Icons.close_rounded, size: 13, color: p.onOverlay),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
