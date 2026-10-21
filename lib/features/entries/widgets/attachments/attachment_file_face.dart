import 'package:flutter/material.dart';

import '../../../../core/theme/theme_context.dart';
import '../../../../domain/models/attachment.dart';

class AttachmentFileFace extends StatelessWidget {
  const AttachmentFileFace({required this.attachment, super.key});

  final Attachment attachment;

  IconData get _icon {
    if (attachment.isVideo) {
      return Icons.play_circle_outline_rounded;
    }

    return switch (attachment.extension) {
      'pdf' => Icons.picture_as_pdf_outlined,
      'doc' || 'docx' || 'txt' || 'rtf' || 'odt' => Icons.description_outlined,
      'xls' || 'xlsx' || 'csv' => Icons.table_chart_outlined,
      'zip' || 'rar' || '7z' => Icons.folder_zip_outlined,
      'mp3' || 'wav' || 'm4a' || 'ogg' => Icons.audiotrack_outlined,
      _ => Icons.insert_drive_file_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 10, 6, 6),
      child: Column(
        children: [
          Icon(_icon, size: 26, color: p.textSecondary),
          const Spacer(),
          Text(
            attachment.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.5, height: 1.15, color: p.text),
          ),
        ],
      ),
    );
  }
}
