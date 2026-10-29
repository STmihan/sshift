import '../../core/utils/dates.dart';
import '../../domain/models/attachment.dart';
import '../../domain/models/attachment_owner.dart';
import '../../domain/models/attachment_owner_type.dart';
import '../../domain/models/backup_format_exception.dart';
import '../../domain/models/backup_rejection.dart';
import '../../domain/models/backup_snapshot.dart';
import '../../domain/models/calendar_event.dart';
import '../../domain/models/pay.dart';
import '../../domain/models/pay_type.dart';
import '../../domain/models/shift.dart';
import '../../domain/models/shift_template.dart';
import '../attachments/attachment_paths.dart';
import '../backup/backup_document.dart';
import 'reminder_mapper.dart';

typedef _Json = Map<String, Object?>;

final _idPattern = RegExp(r'^[A-Za-z0-9_-][A-Za-z0-9._-]*$');
final _isoDatePattern = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');

Map<String, Object?> backupToJson(BackupDocument document) {
  final snapshot = document.snapshot;

  return {
    'format': BackupDocument.format,
    'formatVersion': BackupDocument.currentVersion,
    'appVersion': document.appVersion,
    'exportedAt': _timestampToJson(document.exportedAt),
    'templates': [for (final t in snapshot.templates) _templateToJson(t)],
    'shifts': [for (final s in snapshot.shifts) _shiftToJson(s)],
    'events': [for (final e in snapshot.events) _eventToJson(e)],
    if (snapshot.attachments.isNotEmpty) 'attachments': [for (final a in snapshot.attachments) _attachmentToJson(a)],
  };
}

BackupDocument backupFromJson(Object? json) {
  if (json is! _Json || json['format'] != BackupDocument.format) {
    throw const BackupFormatException(BackupRejection.unrecognized, 'No sshift-backup header');
  }

  final version = json['formatVersion'];

  if (version is! int || version < 1) {
    throw _corrupted('Invalid formatVersion: $version');
  }

  if (version > BackupDocument.currentVersion) {
    throw BackupFormatException(BackupRejection.newerVersion, 'Unsupported formatVersion $version');
  }

  final snapshot = BackupSnapshot(
    templates: _objects(json, 'templates').map(_templateFromJson).toList(),
    shifts: _objects(json, 'shifts').map(_shiftFromJson).toList(),
    events: _objects(json, 'events').map(_eventFromJson).toList(),
    attachments: json.containsKey('attachments')
        ? _objects(json, 'attachments').map(_attachmentFromJson).toList()
        : const [],
  );

  _validateReferences(snapshot);

  return BackupDocument(
    appVersion: _read<String>(json, 'appVersion'),
    exportedAt: _timestampFromJson(json, 'exportedAt'),
    snapshot: snapshot,
  );
}

_Json _templateToJson(ShiftTemplate t) {
  return {
    'id': t.id,
    'title': t.title,
    'icon': t.icon,
    'color': t.color,
    'allDay': t.allDay,
    'startMinute': t.startMinute,
    'endMinute': t.endMinute,
    'breakMinutes': t.breakMinutes,
    'pay': _payToJson(t.defaultPay),
    'location': t.location,
    'sortOrder': t.sortOrder,
    'reminderOffset': t.reminder?.offsetMinutes,
    'updatedAt': _timestampToJson(t.updatedAt),
  };
}

ShiftTemplate _templateFromJson(_Json json) {
  return ShiftTemplate(
    id: _id(json, 'id'),
    title: _read<String>(json, 'title'),
    icon: _read<String>(json, 'icon'),
    color: _read<int>(json, 'color'),
    allDay: _read<bool>(json, 'allDay'),
    startMinute: _read<int>(json, 'startMinute'),
    endMinute: _read<int>(json, 'endMinute'),
    breakMinutes: _read<int>(json, 'breakMinutes'),
    defaultPay: _payFromJson(json),
    location: _read<String>(json, 'location'),
    sortOrder: _read<int>(json, 'sortOrder'),
    reminder: reminderFromColumn(_read<int?>(json, 'reminderOffset')),
    updatedAt: _timestampFromJson(json, 'updatedAt'),
  );
}

_Json _shiftToJson(Shift s) {
  return {
    'id': s.id,
    'templateId': s.templateId,
    'day': isoDate(s.day),
    'allDay': s.allDay,
    'startMinute': s.startMinute,
    'endMinute': s.endMinute,
    'breakMinutes': s.breakMinutes,
    'notes': s.notes,
    'location': s.location,
    'pay': _payToJson(s.pay),
    'reminderOffset': s.reminder?.offsetMinutes,
    'updatedAt': _timestampToJson(s.updatedAt),
  };
}

Shift _shiftFromJson(_Json json) {
  return Shift(
    id: _id(json, 'id'),
    templateId: _id(json, 'templateId'),
    day: _dayFromJson(json, 'day'),
    allDay: _read<bool>(json, 'allDay'),
    startMinute: _read<int>(json, 'startMinute'),
    endMinute: _read<int>(json, 'endMinute'),
    breakMinutes: _read<int>(json, 'breakMinutes'),
    notes: _read<String>(json, 'notes'),
    location: _read<String>(json, 'location'),
    pay: _payFromJson(json),
    reminder: reminderFromColumn(_read<int?>(json, 'reminderOffset')),
    updatedAt: _timestampFromJson(json, 'updatedAt'),
  );
}

_Json _eventToJson(CalendarEvent e) {
  return {
    'id': e.id,
    'day': isoDate(e.day),
    'title': e.title,
    'allDay': e.allDay,
    'startMinute': e.startMinute,
    'endMinute': e.endMinute,
    'notes': e.notes,
    'location': e.location,
    'pay': _payToJson(e.pay),
    'reminderOffset': e.reminder?.offsetMinutes,
    'updatedAt': _timestampToJson(e.updatedAt),
  };
}

CalendarEvent _eventFromJson(_Json json) {
  return CalendarEvent(
    id: _id(json, 'id'),
    day: _dayFromJson(json, 'day'),
    title: _read<String>(json, 'title'),
    allDay: _read<bool>(json, 'allDay'),
    startMinute: _read<int>(json, 'startMinute'),
    endMinute: _read<int>(json, 'endMinute'),
    notes: _read<String>(json, 'notes'),
    location: _read<String>(json, 'location'),
    pay: _payFromJson(json),
    reminder: reminderFromColumn(_read<int?>(json, 'reminderOffset')),
    updatedAt: _timestampFromJson(json, 'updatedAt'),
  );
}

_Json _attachmentToJson(Attachment a) {
  return {
    'id': a.id,
    'ownerType': a.owner.type.name,
    'ownerId': a.owner.id,
    'name': a.name,
    'size': a.size,
    'createdAt': _timestampToJson(a.createdAt),
  };
}

Attachment _attachmentFromJson(_Json json) {
  final id = _id(json, 'id');
  final ownerId = _id(json, 'ownerId');
  final name = _read<String>(json, 'name');

  if (name.isEmpty) {
    throw _corrupted('Attachment $id has an empty name');
  }

  return Attachment(
    id: id,
    owner: AttachmentOwner(_enumByName(AttachmentOwnerType.values, json, 'ownerType'), ownerId),
    name: name,
    path: attachmentRelativePath(ownerId, id, name),
    size: _read<int>(json, 'size'),
    createdAt: _timestampFromJson(json, 'createdAt'),
  );
}

_Json _payToJson(Pay pay) {
  return {'type': pay.type.name, 'amount': pay.amount};
}

Pay _payFromJson(_Json json) {
  final pay = _read<_Json>(json, 'pay');

  return Pay(_enumByName(PayType.values, pay, 'type'), _read<int>(pay, 'amount'));
}

String _timestampToJson(DateTime time) {
  return time.toUtc().toIso8601String();
}

DateTime _timestampFromJson(_Json json, String key) {
  final value = DateTime.tryParse(_read<String>(json, key));

  if (value == null) {
    throw _corrupted('Field "$key" is not a timestamp');
  }

  return value.toLocal();
}

DateTime _dayFromJson(_Json json, String key) {
  final text = _read<String>(json, key);
  final match = _isoDatePattern.firstMatch(text);

  if (match == null) {
    throw _corrupted('Field "$key" is not a date: $text');
  }

  final day = DateTime(int.parse(match[1]!), int.parse(match[2]!), int.parse(match[3]!));

  if (isoDate(day) != text) {
    throw _corrupted('Field "$key" is not a valid date: $text');
  }

  return day;
}

String _id(_Json json, String key) {
  final value = _read<String>(json, key);

  if (!_idPattern.hasMatch(value)) {
    throw _corrupted('Field "$key" is not a valid id: $value');
  }

  return value;
}

T _enumByName<T extends Enum>(List<T> values, _Json json, String key) {
  final name = _read<String>(json, key);

  return values.asNameMap()[name] ?? (throw _corrupted('Unknown value of "$key": $name'));
}

List<_Json> _objects(_Json json, String key) {
  return [
    for (final item in _read<List<Object?>>(json, key))
      if (item is _Json) item else throw _corrupted('Item of "$key" is not an object'),
  ];
}

T _read<T>(_Json json, String key) {
  final value = json[key];

  if (value is T) {
    return value;
  }

  throw _corrupted('Field "$key" is missing or has a wrong type');
}

void _validateReferences(BackupSnapshot snapshot) {
  final templateIds = _uniqueIds('template', snapshot.templates.map((t) => t.id));
  final shiftIds = _uniqueIds('shift', snapshot.shifts.map((s) => s.id));
  final eventIds = _uniqueIds('event', snapshot.events.map((e) => e.id));

  _uniqueIds('attachment', snapshot.attachments.map((a) => a.id));

  for (final shift in snapshot.shifts) {
    if (!templateIds.contains(shift.templateId)) {
      throw _corrupted('Shift ${shift.id} references missing template ${shift.templateId}');
    }
  }

  for (final attachment in snapshot.attachments) {
    final owners = switch (attachment.owner.type) {
      AttachmentOwnerType.shift => shiftIds,
      AttachmentOwnerType.event => eventIds,
    };

    if (!owners.contains(attachment.owner.id)) {
      throw _corrupted('Attachment ${attachment.id} references missing ${attachment.owner}');
    }
  }
}

Set<String> _uniqueIds(String kind, Iterable<String> ids) {
  final seen = <String>{};

  for (final id in ids) {
    if (!seen.add(id)) {
      throw _corrupted('Duplicate $kind id $id');
    }
  }

  return seen;
}

BackupFormatException _corrupted(String message) {
  return BackupFormatException(BackupRejection.corrupted, message);
}
