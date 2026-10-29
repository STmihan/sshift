import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;

import '../../core/utils/dates.dart';
import '../../domain/models/attachment.dart';
import '../../domain/models/backup_format_exception.dart';
import '../../domain/models/backup_rejection.dart';
import '../mappers/backup_json_mapper.dart';
import 'backup_document.dart';

const backupExtension = 'sshift';
const _documentEntry = 'backup.json';
const _attachmentsFolder = 'attachments';

String backupFileName(DateTime exportedAt) {
  return 'sshift-backup-${isoDate(exportedAt)}.$backupExtension';
}

void writeBackupArchive({
  required String target,
  required BackupDocument document,
  required Map<String, String> attachmentFiles,
}) {
  final encoder = ZipFileEncoder()..create(target);

  try {
    encoder.addArchiveFile(ArchiveFile.string(_documentEntry, jsonEncode(backupToJson(document))));

    for (final MapEntry(key: id, value: path) in attachmentFiles.entries) {
      encoder.addArchiveFile(
        ArchiveFile.stream(_attachmentEntry(id), InputFileStream(path))..compression = CompressionType.none,
      );
    }
  } finally {
    encoder.closeSync();
  }
}

BackupDocument readBackupArchive(String path) {
  return _withArchive(path, _readDocument);
}

List<Attachment> extractBackupAttachments(String path, String attachmentsRoot, List<Attachment> attachments) {
  return _withArchive(path, (archive) {
    return [for (final attachment in attachments) _extract(archive, attachment, attachmentsRoot)];
  });
}

T _withArchive<T>(String path, T Function(Archive archive) read) {
  final input = InputFileStream(path);

  try {
    final Archive archive;

    try {
      archive = ZipDecoder().decodeStream(input);
    } on FormatException catch (error) {
      throw BackupFormatException(BackupRejection.unrecognized, 'Not a zip archive: ${error.message}');
    }

    return read(archive);
  } finally {
    input.closeSync();
  }
}

BackupDocument _readDocument(Archive archive) {
  final entry = archive.find(_documentEntry);

  if (entry == null || !entry.isFile) {
    throw const BackupFormatException(BackupRejection.unrecognized, 'No $_documentEntry in the archive');
  }

  final Object? json;

  try {
    json = jsonDecode(utf8.decode(entry.content));
  } on FormatException catch (error) {
    throw BackupFormatException(BackupRejection.corrupted, 'Invalid $_documentEntry: ${error.message}');
  }

  final document = backupFromJson(json);

  for (final attachment in document.snapshot.attachments) {
    if (archive.find(_attachmentEntry(attachment.id)) == null) {
      throw BackupFormatException(BackupRejection.corrupted, 'No file for attachment ${attachment.id}');
    }
  }

  return document;
}

Attachment _extract(Archive archive, Attachment attachment, String root) {
  final target = p.normalize(p.join(root, attachment.path));

  if (!p.isWithin(root, target)) {
    throw BackupFormatException(BackupRejection.corrupted, 'Attachment ${attachment.id} escapes the attachments root');
  }

  final entry = archive.find(_attachmentEntry(attachment.id));

  if (entry == null) {
    throw BackupFormatException(BackupRejection.corrupted, 'No file for attachment ${attachment.id}');
  }

  File(target).parent.createSync(recursive: true);
  final output = OutputFileStream(target);

  try {
    entry.writeContent(output);
  } finally {
    output.closeSync();
  }

  return Attachment(
    id: attachment.id,
    owner: attachment.owner,
    name: attachment.name,
    path: attachment.path,
    size: File(target).lengthSync(),
    createdAt: attachment.createdAt,
  );
}

String _attachmentEntry(String attachmentId) {
  return '$_attachmentsFolder/$attachmentId';
}
