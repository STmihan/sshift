import 'dart:math';

import '../../core/utils/dates.dart';
import '../../domain/models/attachment_owner_type.dart';
import '../../domain/models/backup_snapshot.dart';
import '../../domain/models/calendar_event.dart';
import '../../domain/models/shift_template.dart';

BackupSnapshot backupAdditions({required BackupSnapshot backup, required BackupSnapshot local}) {
  final templateIds = {for (final t in local.templates) t.id};
  final localTemplateByContent = <Object, String>{};

  for (final t in local.templates) {
    localTemplateByContent.putIfAbsent(_templateContent(t), () => t.id);
  }

  final templateIdMap = <String, String>{};
  final newTemplates = <ShiftTemplate>[];

  for (final t in backup.templates) {
    final twin = localTemplateByContent[_templateContent(t)];

    if (templateIds.contains(t.id)) {
      templateIdMap[t.id] = t.id;
    } else if (twin != null) {
      templateIdMap[t.id] = twin;
    } else {
      templateIdMap[t.id] = t.id;
      newTemplates.add(t);
    }
  }

  newTemplates.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

  final shiftIds = {for (final s in local.shifts) s.id};
  final takenDays = {for (final s in local.shifts) (s.templateId, dayKey(s.day))};
  final shifts = [
    for (final s in backup.shifts)
      if (!shiftIds.contains(s.id) && takenDays.add((templateIdMap[s.templateId]!, dayKey(s.day))))
        s.copyWith(templateId: templateIdMap[s.templateId]),
  ];
  final eventIds = {for (final e in local.events) e.id};
  final eventContents = {for (final e in local.events) _eventContent(e)};
  final events = backup.events
      .where((e) => !eventIds.contains(e.id) && !eventContents.contains(_eventContent(e)))
      .toList();
  final attachmentIds = {for (final a in local.attachments) a.id};
  final newOwners = {
    AttachmentOwnerType.shift: {for (final s in shifts) s.id},
    AttachmentOwnerType.event: {for (final e in events) e.id},
  };
  final firstSortOrder = local.templates.fold(0, (next, t) => max(next, t.sortOrder + 1));

  return BackupSnapshot(
    templates: [for (final (index, t) in newTemplates.indexed) t.copyWith(sortOrder: firstSortOrder + index)],
    shifts: shifts,
    events: events,
    attachments: backup.attachments
        .where((a) => !attachmentIds.contains(a.id) && newOwners[a.owner.type]!.contains(a.owner.id))
        .toList(),
  );
}

Object _templateContent(ShiftTemplate t) {
  return (
    t.title,
    t.icon,
    t.color,
    t.allDay,
    t.startMinute,
    t.endMinute,
    t.breakMinutes,
    t.defaultPay,
    t.location,
    t.reminder,
  );
}

Object _eventContent(CalendarEvent e) {
  return (
    dayKey(e.day),
    e.title,
    e.allDay,
    e.startMinute,
    e.endMinute,
    e.notes,
    e.location,
    e.pay,
    e.reminder,
  );
}
