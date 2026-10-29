import 'backup_rejection.dart';

class BackupFormatException implements Exception {
  const BackupFormatException(this.reason, this.message);

  final BackupRejection reason;
  final String message;

  @override
  String toString() {
    return 'BackupFormatException(${reason.name}): $message';
  }
}
