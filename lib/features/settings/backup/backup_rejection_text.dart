import '../../../domain/models/backup_rejection.dart';
import '../../../l10n/app_localizations.dart';

String backupRejectionText(AppLocalizations l, BackupRejection reason) {
  return switch (reason) {
    BackupRejection.unrecognized => l.backupUnrecognized,
    BackupRejection.newerVersion => l.backupNewerVersion,
    BackupRejection.corrupted => l.backupCorrupted,
  };
}
