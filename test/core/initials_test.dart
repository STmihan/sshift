import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/core/utils/initials.dart';

void main() {
  test('initialsOf builds a short icon from a title', () {
    expect(initialsOf('Day Morning'), 'DM');
    expect(initialsOf('night'), 'NI');
    expect(initialsOf('  '), '');
  });
}
