import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/core/utils/versions.dart';

void main() {
  test('isNewerVersion compares semantic versions', () {
    expect(isNewerVersion('1.0.1', '1.0.0'), isTrue);
    expect(isNewerVersion('1.10.0', '1.9.3'), isTrue);
    expect(isNewerVersion('1.0.0', '1.0.0'), isFalse);
    expect(isNewerVersion('0.9.0', '1.0.0'), isFalse);
    expect(isNewerVersion('not-a-version', '1.0.0'), isFalse);
  });
}
