import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sshift/data/repositories/github_updates_repository.dart';
import 'package:sshift/domain/models/app_update.dart';

AppUpdate _update(String version, {int size = 4}) {
  return AppUpdate(
    version: version,
    notes: '',
    apkUrl: 'https://example.com/$version.apk',
    apkSize: size,
    releaseUrl: '',
  );
}

void main() {
  late Directory directory;
  late GithubUpdatesRepository repository;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('updates');
    repository = GithubUpdatesRepository(downloadsDirectory: () async => directory);
  });

  tearDown(() async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  });

  test('findDownloadedApk returns a complete file', () async {
    await File(p.join(directory.path, 'sshift-1.0.2.apk')).writeAsBytes([1, 2, 3, 4]);

    expect(await repository.findDownloadedApk(_update('1.0.2')), isNotNull);
  });

  test('findDownloadedApk ignores and removes a file of the wrong size', () async {
    final file = File(p.join(directory.path, 'sshift-1.0.2.apk'));

    await file.writeAsBytes([1, 2]);

    expect(await repository.findDownloadedApk(_update('1.0.2')), isNull);
    expect(await file.exists(), isFalse);
  });

  test('clearDownloads keeps only the pending update', () async {
    await File(p.join(directory.path, 'sshift-1.0.1.apk')).writeAsBytes([1]);
    await File(p.join(directory.path, 'sshift-1.0.2.apk')).writeAsBytes([1, 2, 3, 4]);
    await File(p.join(directory.path, 'sshift-1.0.3.apk.part')).writeAsBytes([1]);

    await repository.clearDownloads(keep: _update('1.0.2'));

    final names = directory.listSync().map((e) => p.basename(e.path)).toList();

    expect(names, ['sshift-1.0.2.apk']);
  });
}
