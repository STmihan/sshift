import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/features/updates/release_notes.dart';

void main() {
  test('releaseNotesToPlainText cleans GitHub generated notes', () {
    const markdown =
        '## What\'s Changed\n'
        '* Add GitHub link to settings by @STmihan in https://github.com/STmihan/sshift/pull/1\n'
        '* **Faster** calendar\n'
        '\n'
        '**Full Changelog**: https://github.com/STmihan/sshift/compare/v1.0.0...v1.1.0';

    expect(
      releaseNotesToPlainText(markdown),
      "What's Changed\n• Add GitHub link to settings\n• Faster calendar",
    );
  });
}
