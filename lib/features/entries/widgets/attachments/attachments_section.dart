import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';

import '../../../../core/logger.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/group_card.dart';
import '../../../../core/widgets/section_label.dart';
import '../../../../data/data_providers.dart';
import '../../../../domain/models/attachment.dart';
import '../../../../domain/models/attachment_owner.dart';
import '../../../../l10n/app_localizations.dart';
import '../../attachments_providers.dart';
import 'attachment_add_button.dart';
import 'attachment_pickers.dart';
import 'attachment_tile.dart';

class AttachmentsSection extends ConsumerStatefulWidget {
  const AttachmentsSection({required this.owner, super.key});

  final AttachmentOwner owner;

  @override
  ConsumerState<AttachmentsSection> createState() {
    return _AttachmentsSectionState();
  }
}

class _AttachmentsSectionState extends ConsumerState<AttachmentsSection> {
  bool _busy = false;

  Future<void> _add(Future<List<XFile>> Function(int limit) pick, int remaining) async {
    if (remaining <= 0 || _busy) {
      return;
    }

    setState(() => _busy = true);

    try {
      final files = await pick(remaining);
      final repository = ref.read(attachmentsRepositoryProvider);

      for (final file in files.take(remaining)) {
        await repository.add(widget.owner, file);
      }

      if (files.isNotEmpty) {
        talker.info('Attached ${files.length} file(s) to ${widget.owner}');
      }
    } on Exception catch (error, stack) {
      talker.handle(error, stack, 'Attach failed');
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _open(Attachment attachment) async {
    final messenger = ScaffoldMessenger.of(context);
    final failedText = AppLocalizations.of(context).openFileFailed;
    final path = await ref.read(attachmentsRepositoryProvider).resolvePath(attachment);
    final result = await OpenFilex.open(path);

    if (result.type == ResultType.done) {
      return;
    }

    talker.warning('Open failed: ${result.message}');
    messenger.showSnackBar(SnackBar(content: Text(failedText)));
  }

  Future<void> _delete(Attachment attachment) async {
    final confirmed = await confirmDelete(
      context,
      title: AppLocalizations.of(context).deleteAttachment,
      body: attachment.name,
    );

    if (!confirmed) {
      return;
    }

    await ref.read(attachmentsRepositoryProvider).delete(attachment);
    talker.info('Attachment deleted: ${attachment.id}');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final attachments = ref.watch(attachmentsProvider(widget.owner)).value ?? const [];
    final remaining = Attachment.maxPerOwner - attachments.length;
    final canAdd = remaining > 0 && !_busy;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionLabel(
          l.attachments,
          trailing: Text(
            l.attachmentsCount(attachments.length, Attachment.maxPerOwner),
            style: TextStyle(fontSize: 13, color: p.textSecondary),
          ),
        ),
        GroupCard(
          padding: const EdgeInsets.all(12),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (attachments.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final attachment in attachments)
                        AttachmentTile(
                          attachment: attachment,
                          onTap: () => _open(attachment),
                          onDelete: () => _delete(attachment),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                Row(
                  children: [
                    Expanded(
                      child: AttachmentAddButton(
                        icon: Icons.photo_library_outlined,
                        label: l.attachPhotoVideo,
                        onTap: canAdd ? () => _add(pickGalleryMedia, remaining) : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AttachmentAddButton(
                        icon: Icons.attach_file_rounded,
                        label: l.attachFile,
                        onTap: canAdd ? () => _add(pickAnyFiles, remaining) : null,
                      ),
                    ),
                  ],
                ),
                if (_busy)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LinearProgressIndicator(minHeight: 2, color: p.accent, backgroundColor: p.background),
                  )
                else if (remaining <= 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      l.attachmentsLimit(Attachment.maxPerOwner),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: p.textSecondary),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
