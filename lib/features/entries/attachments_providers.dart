import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_providers.dart';
import '../../domain/models/attachment.dart';
import '../../domain/models/attachment_owner.dart';

final attachmentsProvider = StreamProvider.autoDispose.family<List<Attachment>, AttachmentOwner>((ref, owner) {
  return ref.watch(attachmentsRepositoryProvider).watchFor(owner);
});
