import 'package:flutter/foundation.dart';

import 'pay_type.dart';

@immutable
class Pay {
  const Pay(this.type, this.amount);

  static const none = Pay(PayType.none, 0);

  final PayType type;
  final int amount;

  bool get isSet => type != PayType.none;

  int totalFor(int workedMinutes) {
    return switch (type) {
      PayType.none => 0,
      PayType.fixed => amount,
      PayType.hourly => (amount * workedMinutes / 60).round(),
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Pay && other.type == type && other.amount == amount;
  }

  @override
  int get hashCode => Object.hash(type, amount);

  @override
  String toString() {
    return 'Pay(${type.name}, $amount)';
  }
}
