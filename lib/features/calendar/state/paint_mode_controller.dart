import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'paint_mode.dart';

final paintModeProvider = NotifierProvider<PaintModeController, PaintMode?>(PaintModeController.new);

class PaintModeController extends Notifier<PaintMode?> {
  @override
  PaintMode? build() {
    return null;
  }

  void start(String? templateId) {
    state = PaintMode(templateId: templateId);
  }

  void select(String templateId) {
    state = PaintMode(templateId: templateId);
  }

  void stop() {
    state = null;
  }
}
