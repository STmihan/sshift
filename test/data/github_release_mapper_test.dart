import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/data/mappers/github_release_mapper.dart';

void main() {
  test('maps a release with an APK asset', () {
    final update = appUpdateFromGithubRelease({
      'tag_name': 'v1.2.3',
      'body': 'Notes',
      'html_url': 'https://github.com/STmihan/sshift/releases/tag/v1.2.3',
      'assets': [
        {'name': 'checksums.txt', 'browser_download_url': 'https://example.com/checksums.txt', 'size': 10},
        {'name': 'sshift-1.2.3.apk', 'browser_download_url': 'https://example.com/sshift.apk', 'size': 64000000},
      ],
    });

    expect(update, isNotNull);
    expect(update!.version, '1.2.3');
    expect(update.apkUrl, 'https://example.com/sshift.apk');
    expect(update.apkSize, 64000000);
    expect(update.notes, 'Notes');
  });

  test('returns null without an APK asset', () {
    expect(appUpdateFromGithubRelease({'tag_name': 'v1.2.3', 'assets': <Object?>[]}), isNull);
  });
}
