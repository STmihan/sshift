import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void keepAliveAfterUse(Ref ref, Duration duration) {
  final link = ref.keepAlive();
  Timer? timer;

  ref.onCancel(() {
    timer = Timer(duration, link.close);
  });
  ref.onResume(() {
    timer?.cancel();
  });
  ref.onDispose(() {
    timer?.cancel();
  });
}
