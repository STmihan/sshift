import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/data/mappers/app_update_json_mapper.dart';
import 'package:sshift/domain/models/app_update.dart';

void main() {
  test('cached update survives a JSON round trip', () {
    const update = AppUpdate(
      version: '1.0.2',
      notes: 'Notes',
      apkUrl: 'https://example.com/sshift.apk',
      apkSize: 42,
      releaseUrl: 'https://example.com/release',
    );

    final restored = appUpdateFromJson(appUpdateToJson(update));

    expect(restored?.version, update.version);
    expect(restored?.apkUrl, update.apkUrl);
    expect(restored?.apkSize, update.apkSize);
    expect(restored?.notes, update.notes);
  });
}
