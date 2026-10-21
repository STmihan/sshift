import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_providers.dart';
import '../../domain/models/attachment.dart';

final shiftAttachmentsProvider = StreamProvider.autoDispose.family<List<Attachment>, String>(
  (ref, shiftId) => ref.watch(attachmentsRepositoryProvider).watchForShift(shiftId),
);
