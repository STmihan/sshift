import 'package:path/path.dart' as p;

String attachmentRelativePath(String ownerId, String attachmentId, String name) {
  return p.join(ownerId, '${attachmentId}_${_safeFileName(name)}');
}

String _safeFileName(String name) {
  return name.replaceAll(RegExp(r'[\/:*?"<>|]'), '_');
}
