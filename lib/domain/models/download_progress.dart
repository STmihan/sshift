import 'package:flutter/foundation.dart';

@immutable
class DownloadProgress {
  const DownloadProgress({required this.received, required this.total, this.filePath});

  final int received;
  final int total;
  final String? filePath;

  bool get isComplete => filePath != null;

  double? get fraction => total > 0 ? (received / total).clamp(0, 1) : null;
}
