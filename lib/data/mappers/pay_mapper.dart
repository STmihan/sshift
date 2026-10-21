import '../../domain/models/pay.dart';
import '../../domain/models/pay_type.dart';

Pay payFromColumns(int type, int amount) {
  return Pay(PayType.values[type], amount);
}

List<Pay> distinctPays(Iterable<Pay> pays, int limit) {
  final seen = <Pay>{};

  for (final pay in pays) {
    if (seen.add(pay) && seen.length == limit) {
      break;
    }
  }

  return seen.toList();
}
