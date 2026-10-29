import 'package:flutter/foundation.dart';

import 'attachment.dart';
import 'calendar_event.dart';
import 'shift.dart';
import 'shift_template.dart';

@immutable
class BackupSnapshot {
  const BackupSnapshot({
    required this.templates,
    required this.shifts,
    required this.events,
    required this.attachments,
  });

  final List<ShiftTemplate> templates;
  final List<Shift> shifts;
  final List<CalendarEvent> events;
  final List<Attachment> attachments;

  BackupSnapshot withAttachments(List<Attachment> attachments) {
    return BackupSnapshot(templates: templates, shifts: shifts, events: events, attachments: attachments);
  }
}
