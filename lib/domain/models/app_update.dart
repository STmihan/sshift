import 'package:flutter/foundation.dart';

@immutable
class AppUpdate {
  const AppUpdate({
    required this.version,
    required this.notes,
    required this.apkUrl,
    required this.apkSize,
    required this.releaseUrl,
  });

  final String version;
  final String notes;
  final String apkUrl;
  final int apkSize;
  final String releaseUrl;
}
