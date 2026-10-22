import 'package:pub_semver/pub_semver.dart';

bool isNewerVersion(String candidate, String current) {
  try {
    return Version.parse(candidate) > Version.parse(current);
  } on FormatException {
    return false;
  }
}
