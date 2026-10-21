import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDayProvider = NotifierProvider<SelectedDayController, int?>(SelectedDayController.new);

class SelectedDayController extends Notifier<int?> {
  @override
  int? build() {
    return null;
  }

  void select(int? dayKey) {
    state = dayKey;
  }
}
