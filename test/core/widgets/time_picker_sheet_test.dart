import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sshift/core/theme/app_theme.dart';
import 'package:sshift/core/widgets/time_format_scope.dart';
import 'package:sshift/core/widgets/time_picker/pick_time.dart';
import 'package:sshift/domain/models/time_format.dart';
import 'package:sshift/l10n/app_localizations.dart';

Widget _app({required TimeFormat format, required ValueChanged<int?> onPicked}) {
  return MaterialApp(
    locale: const Locale('ru'),
    theme: buildTheme(Brightness.light),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    builder: (context, child) {
      return TimeFormatScope(format: format, child: child!);
    },
    home: Builder(
      builder: (context) {
        return Scaffold(
          body: TextButton(
            onPressed: () async {
              onPicked(await pickTime(context, title: 'Start', minute: 22 * 60 + 7));
            },
            child: const Text('open'),
          ),
        );
      },
    ),
  );
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  testWidgets('12-hour format works in Russian locale', (tester) async {
    int? picked;

    await tester.pumpWidget(_app(format: TimeFormat.hours12, onPicked: (value) => picked = value));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('10:07 PM'), findsOneWidget);
    expect(find.text('AM'), findsOneWidget);

    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();

    expect(picked, 22 * 60 + 7);
  });

  testWidgets('24-hour format has no day period wheel', (tester) async {
    await tester.pumpWidget(_app(format: TimeFormat.hours24, onPicked: (_) {}));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('22:07'), findsOneWidget);
    expect(find.text('AM'), findsNothing);
  });
}
