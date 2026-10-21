import 'package:uuid/uuid.dart';

const _uuid = Uuid();

String newId() {
  return _uuid.v4();
}
