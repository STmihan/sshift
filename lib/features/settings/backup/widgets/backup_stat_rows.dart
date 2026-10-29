import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/field_row.dart';
import '../../../../domain/models/backup_stats.dart';
import '../../../../l10n/app_localizations.dart';

List<Widget> backupStatRows(BuildContext context, BackupStats stats) {
  final l = AppLocalizations.of(context);

  return [
    FieldRow(label: l.backupShiftTypes, value: '${stats.templates}'),
    FieldRow(label: l.backupShifts, value: '${stats.shifts}'),
    FieldRow(label: l.backupEvents, value: '${stats.events}'),
    FieldRow(
      label: l.backupFiles,
      value: stats.attachments == 0
          ? '0'
          : l.backupFilesValue(stats.attachments, formatMegabytes(context, stats.attachmentBytes)),
    ),
  ];
}
