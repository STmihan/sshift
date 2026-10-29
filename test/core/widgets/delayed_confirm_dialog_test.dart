import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/core/theme/app_theme.dart';
import 'package:sshift/core/widgets/delayed_confirm_dialog.dart';
import 'package:sshift/l10n/app_localizations.dart';

Widget _app(ValueChanged<bool> onResult) {
  return MaterialApp(
    locale: const Locale('en'),
    theme: buildTheme(Brightness.light),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Builder(
      builder: (context) {
        return Scaffold(
          body: TextButton(
            onPressed: () async {
              onResult(
                await confirmWithDelay(context, title: 'Title', body: 'Body', delay: const Duration(seconds: 5)),
              );
            },
            child: const Text('open'),
          ),
        );
      },
    ),
  );
}

TextButton _yesButton(WidgetTester tester) {
  return tester.widget<TextButton>(find.ancestor(of: find.textContaining('Yes'), matching: find.byType(TextButton)));
}

void main() {
  testWidgets('Yes stays disabled with a countdown for five seconds', (tester) async {
    bool? result;

    await tester.pumpWidget(_app((value) => result = value));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('Yes (5)'), findsOneWidget);
    expect(_yesButton(tester).onPressed, isNull);

    await tester.pump(const Duration(seconds: 4));

    expect(find.text('Yes (1)'), findsOneWidget);
    expect(_yesButton(tester).onPressed, isNull);

    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Yes'), findsOneWidget);

    await tester.tap(find.text('Yes'));
    await tester.pumpAndSettle();

    expect(result, isTrue);
  });

  testWidgets('Cancel returns false', (tester) async {
    bool? result;

    await tester.pumpWidget(_app((value) => result = value));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(result, isFalse);
  });
}
