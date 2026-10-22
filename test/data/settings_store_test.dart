import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sshift/data/database/app_database.dart';
import 'package:sshift/data/repositories/stored_settings_repository.dart';
import 'package:sshift/data/settings/settings_store.dart';
import 'package:sshift/domain/models/app_settings.dart';
import 'package:sshift/domain/models/time_format.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  test('empty store gives default settings', () async {
    final repository = StoredSettingsRepository(await SettingsStore.open(db));

    final settings = repository.load();

    expect(settings.languageCode, isNull);
    expect(settings.currency, AppSettings.defaultCurrency);
    expect(settings.timeFormat, TimeFormat.system);
    expect(settings.notificationsEnabled, isTrue);
  });

  test('saved settings survive reopening the store', () async {
    await StoredSettingsRepository(await SettingsStore.open(db)).save(
      const AppSettings(
        languageCode: 'ru',
        currency: 'USD',
        firstDayOfWeek: 1,
        timeFormat: TimeFormat.hours24,
        notificationsEnabled: false,
      ),
    );

    final settings = StoredSettingsRepository(await SettingsStore.open(db)).load();

    expect(settings.languageCode, 'ru');
    expect(settings.currency, 'USD');
    expect(settings.firstDayOfWeek, 1);
    expect(settings.timeFormat, TimeFormat.hours24);
    expect(settings.notificationsEnabled, isFalse);
  });

  test('clearing an optional setting removes it', () async {
    final repository = StoredSettingsRepository(await SettingsStore.open(db));

    await repository.save(const AppSettings(languageCode: 'ru'));
    await repository.save(const AppSettings());

    expect(StoredSettingsRepository(await SettingsStore.open(db)).load().languageCode, isNull);
  });
}
