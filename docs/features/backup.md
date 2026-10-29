# Data export and import

Settings → "Data" lets the user export everything they created into a single `.sshift` file and restore it later
(new phone, reinstall). Import has two modes: **add** (keep local records, add only new ones from the backup) and
**replace** (wipe local records, take the backup). The same group has "Delete all data".

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
3. A preview sheet shows the backup date and counts and a mode switch: "Add" (selected first, the safe choice) or
   "Replace" (the hint turns red and warns that current data will be deleted).
4. Apply the chosen mode (below). The snackbar reports how many records were added (add) or that data was replaced.
5. UI and reminders refresh on their own: Drift `watch` streams fire on table changes and `ReminderSync` listens to
   them.

### Replace

1. All attachment files are extracted into `attachments_import/` next to the live `attachments/` directory.
2. One Drift transaction deletes the four tables and inserts the backup data.
3. On success `attachments` → `attachments_old`, `attachments_import` → `attachments`, `attachments_old` is deleted.
4. On failure in steps 1–2 `attachments_import` is deleted and nothing changes.

### Add (merge)

Local records always win: nothing local is changed or deleted. `backupAdditions` (a pure function in
`data/backup/backup_additions.dart`) decides what is new:

- **Shift type** — skipped when its id exists locally, or when a local type has identical content (all fields except
  id, `sortOrder` and `updatedAt`). In the second case the backup's shifts are re-pointed to the local type.
  New types keep their relative order and are appended after the local ones (`sortOrder` = local max + 1, …).
- **Shift** — skipped when its id exists locally, or when that day already has a shift of the same type (after the
  re-pointing above). Paint mode treats "one shift of a type per day" as a rule (`toggleShift`), and a second one
  would double the earnings in reports. The same rule removes duplicates inside the backup itself.
- **Event** — skipped when its id exists locally, or when a local event has identical content (day, title, time,
  notes, location, pay, reminder; `updatedAt` is ignored). Several different events on one day are fine.
- **Attachment** — imported only for shifts/events added by this merge; a local record keeps its own files.

Importing the same backup twice adds nothing the second time.

Apply: the selected attachments are extracted into `attachments_import/`, moved one by one into `attachments/`, then
one transaction inserts the new rows. If anything fails, the moved files are deleted again; `attachments_import/` is
always removed.

## Delete all data

"Delete all data" (red row) opens a confirmation dialog whose "Yes" button stays disabled with a countdown for
5 seconds (`DelayedConfirmDialog`). Confirming deletes the four tables in one transaction and the whole attachments
folder. The `settings` table stays. Reminders are cancelled by `ReminderSync`, which reacts to the empty tables.

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
- `domain/models/backup_import_mode.dart` — `merge`, `replace`.
- `domain/repositories/backup_repository.dart` — `currentStats`, `export`, `inspect`, `restore(path, mode)` (returns
  stats of what was written), `deleteAll`.
- `data/backup/backup_document.dart` — snapshot plus header, format name and current version.
- `data/backup/backup_archive.dart` — zip read/write, extraction of a given list of attachments, run inside isolates.
- `data/backup/backup_additions.dart` — merge rules: which backup records are new for this device.
- `data/mappers/backup_json_mapper.dart` — domain models ↔ JSON, field and reference validation.
- `data/mappers/*_row_mapper.dart` — Drift rows ↔ domain models, shared with the regular repositories.
- `data/repositories/drift_backup_repository.dart` — bulk read, replace, merge, delete all.
- `features/settings/backup/` — export sheet, import flow and sheet, delete-all flow.
- `core/widgets/delayed_confirm_dialog.dart` — confirmation dialog with a delayed "Yes".

## Tests

`test/data/drift_backup_repository_test.dart` covers the round trip (rows and file bytes), export without files,
skipping draft attachments, and rejection of non-zip files, newer versions, broken references, missing attachment
files and path-like ids, checking that a rejected import leaves rows and files untouched. It also covers merge
(local records kept, only new added, sort order appended, same-day shift skipped, identical shift type reused,
identical event skipped, second merge adds nothing) and `deleteAll`. `test/core/widgets/delayed_confirm_dialog_test.dart`
checks the 5-second countdown.
