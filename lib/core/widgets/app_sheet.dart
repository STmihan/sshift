import 'package:flutter/material.dart';

import '../theme/dimensions.dart';
import 'sheet_frame.dart';

Future<T?> showAppSheet<T>(BuildContext context, WidgetBuilder builder) {
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: contentMaxWidth),
    builder: (context) => SheetFrame(child: builder(context)),
  );
}
