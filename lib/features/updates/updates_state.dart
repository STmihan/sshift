import 'package:flutter/foundation.dart';

import '../../domain/models/app_update.dart';

@immutable
class UpdatesState {
  const UpdatesState({this.available, this.checking = false});

  final AppUpdate? available;
  final bool checking;
}
