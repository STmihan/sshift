import 'package:flutter/foundation.dart';

import 'backup_snapshot.dart';

@immutable
class BackupStats {
  const BackupStats({
    required this.templates,
    required this.shifts,
    required this.events,
    required this.attachments,
    required this.attachmentBytes,
  });

  factory BackupStats.of(BackupSnapshot snapshot) {
    return BackupStats(
      templates: snapshot.templates.length,
      shifts: snapshot.shifts.length,
      events: snapshot.events.length,
      attachments: snapshot.attachments.length,
      attachmentBytes: snapshot.attachments.fold(0, (sum, a) => sum + a.size),
    );
  }

  final int templates;
  final int shifts;
  final int events;
  final int attachments;
  final int attachmentBytes;
}
