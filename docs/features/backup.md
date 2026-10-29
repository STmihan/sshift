# Data export and import

Settings → "Data" lets the user export everything they created into a single `.sshift` file and restore it later
(new phone, reinstall). The only import mode is **replace everything**; merging is intentionally out of scope, now
and later (sync will be a separate feature).

## What is included

| Included                    | Excluded                                                         |
|-----------------------------|------------------------------------------------------------------|
| `shift_templates`           | `settings` table (language, theme, currency, week start, time    |
| `shifts`                    | format, notifications, update checker cache)                     |
| `events`                    |                                                                  |
| `attachments` + their files |                                                                  |

The `settings` table holds what used to live in SharedPreferences. It is never read or written by export/import, so
after a restore the device keeps its own preferences.

## File format

A `.sshift` file is a zip archive:

```
backup.json
attachments/<attachmentId>
```

Archive entries are named by attachment id only, so nothing from the stored file path ends up in the archive.
Attachment files are stored without compression (photos and videos are already compressed); `backup.json` is
deflated.

`backup.json` describes **domain models**, not Drift rows, so the format does not depend on the Drift
`schemaVersion` and survives replacing Drift with another storage.

```json
{
  "format": "sshift-backup",
  "formatVersion": 1,
  "appVersion": "1.4.0",
  "exportedAt": "2026-10-29T10:00:00.000Z",
  "templates": [
    {
      "id": "…", "title": "Day", "icon": "D", "color": 4283215696,
      "allDay": false, "startMinute": 540, "endMinute": 1020, "breakMinutes": 60,
      "pay": { "type": "hourly", "amount": 50000 },
      "location": "", "sortOrder": 0, "reminderOffset": null,
      "updatedAt": "2026-10-20T08:00:00.000Z"
    }
  ],
  "shifts": [
    {
      "id": "…", "templateId": "…", "day": "2026-10-29",
      "allDay": false, "startMinute": 540, "endMinute": 1020, "breakMinutes": 60,
      "notes": "", "location": "", "pay": { "type": "none", "amount": 0 },
      "reminderOffset": -60, "updatedAt": "…"
    }
  ],
  "events": [
    {
      "id": "…", "day": "2026-10-29", "title": "Doctor",
      "allDay": false, "startMinute": 600, "endMinute": 660,
      "notes": "", "location": "", "pay": { "type": "none", "amount": 0 },
      "reminderOffset": null, "updatedAt": "…"
    }
  ],
  "attachments": [
    { "id": "…", "ownerType": "shift", "ownerId": "…", "name": "photo.jpg", "size": 123456, "createdAt": "…" }
  ]
}
```

Rules:

- Enums (`pay.type`, `ownerType`) are written by name, never by index.
- `day` is an ISO date (`yyyy-MM-dd`), timestamps are UTC ISO-8601.
- `attachments` is omitted when the user exports without attachments.
- The stored `path` of an attachment is not exported. On import the path is rebuilt with `attachmentRelativePath`
  (`<ownerId>/<id>_<safeName>`), the same helper `DriftAttachmentsRepository` uses.
- Ids must match `^[A-Za-z0-9_-][A-Za-z0-9._-]*$`, so an id can never contain a path separator or be `.`/`..`.
- `size` is informational (preview); after extraction the real file length is stored.
- `formatVersion` is independent of the Drift schema. Older versions are upgraded by the mapper; a newer version is
  rejected with "update the app".

## Export flow

1. "Export" opens a sheet with a summary of the current data (templates, shifts, events, attachments and their size)
   and an "Include attachments" switch.
2. Only data that can be imported back is exported: shifts whose template is missing, attachments of unsaved drafts
   and attachments whose file is gone from disk are skipped. The summary uses the same filter.
3. The archive is written to `<temp>/backup/export/` (cleared before each export) in a background isolate.
4. The file is handed to the system share sheet (`share_plus`). `FilePicker.saveFile` is not used because on Android
   it needs the whole file as bytes in memory, which is risky with video attachments.

## Import flow

1. The user picks a file with `FilePicker.pickFile()` (any type); Android extension filters are unreliable
   for custom extensions, so content is validated instead.
2. The whole file is validated before anything changes. The import is rejected when:
   - `format` is unknown or `formatVersion` is newer than supported;
   - ids are duplicated or enum values are unknown;
   - a shift references a template that is not in the file;
   - an attachment references a shift/event that is not in the file;
   - an attachment file is missing in the archive.
   Only archive entries described in `attachments` are extracted, and every target path must stay inside the
   attachments root (protection against `../` entries).
3. A preview sheet shows the backup date and counts and warns that current data will be replaced.
4. Apply:
   1. attachment files are extracted into `attachments_import/` next to the live `attachments/` directory;
   2. one Drift transaction deletes the four tables and inserts the backup data;
   3. on success `attachments` → `attachments_old`, `attachments_import` → `attachments`, `attachments_old` is deleted;
   4. on failure in steps 1–2 `attachments_import` is deleted and nothing changes.
5. UI and reminders refresh on their own: Drift `watch` streams fire on table changes and `ReminderSync` listens to
   them.

No Drift schema change is needed, so there is no migration.

## Isolates

Zip reading and writing is synchronous `package:archive` code and runs through `Isolate.run`. The calls live in
static helpers of `DriftBackupRepository`: a closure created inside an instance method can capture `this`
(the repository holding `AppDatabase`), which cannot be sent to another isolate. `BackupFormatException` is a plain
immutable object, so it crosses the isolate boundary with its type intact.

## Code layout

- `domain/models/backup_snapshot.dart` — templates, shifts, events, attachments as domain models.
- `domain/models/backup_stats.dart`, `backup_info.dart` — counts and the backup header shown in the sheets.
- `domain/models/backup_rejection.dart`, `backup_format_exception.dart` — why a file was rejected
  (`unrecognized`, `newerVersion`, `corrupted`).
- `domain/repositories/backup_repository.dart` — `currentStats`, `export`, `inspect`, `restore`.
- `data/backup/backup_document.dart` — snapshot plus header, format name and current version.
- `data/backup/backup_archive.dart` — zip read/write/extract, run inside isolates.
- `data/mappers/backup_json_mapper.dart` — domain models ↔ JSON, field and reference validation.
- `data/mappers/*_row_mapper.dart` — Drift rows ↔ domain models, shared with the regular repositories.
- `data/repositories/drift_backup_repository.dart` — bulk read, transactional replace, attachments folder swap.
- `features/settings/backup/` — export sheet, import flow and sheet.

## Tests

`test/data/drift_backup_repository_test.dart` covers the round trip (rows and file bytes), export without files,
skipping draft attachments, and rejection of non-zip files, newer versions, broken references, missing attachment
files and path-like ids, checking that a rejected import leaves rows and files untouched.
