// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'SShift';

  @override
  String appVersion(String app, String version) {
    return '$app $version';
  }

  @override
  String get navCalendar => 'Календарь';

  @override
  String get navReports => 'Отчёты';

  @override
  String get navShifts => 'Смены';

  @override
  String get navSettings => 'Настройки';

  @override
  String get shift => 'Смена';

  @override
  String get event => 'Событие';

  @override
  String get addShift => 'Добавить смену';

  @override
  String get newShift => 'Новая смена';

  @override
  String get untitled => 'Без названия';

  @override
  String get title => 'Название';

  @override
  String get icon => 'Иконка';

  @override
  String get color => 'Цвет';

  @override
  String get allDay => 'Весь день';

  @override
  String get start => 'Начало';

  @override
  String get end => 'Конец';

  @override
  String get nextDay => '(след. день)';

  @override
  String get breakLabel => 'Перерыв';

  @override
  String get none => 'Нет';

  @override
  String get notes => 'Заметки';

  @override
  String get location => 'Место';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get today => 'Сегодня';

  @override
  String get done => 'Готово';

  @override
  String doneCount(int count) {
    return 'Готово ($count)';
  }

  @override
  String get defaultValues => 'Значения по умолчанию';

  @override
  String get paintHint => 'Выберите смену и нажимайте на дни';

  @override
  String get pay => 'Оплата';

  @override
  String get payNone => 'Нет';

  @override
  String get payFixed => 'Фикс';

  @override
  String get payHourly => 'Почасовая';

  @override
  String get payAmount => 'Сумма';

  @override
  String get payRate => 'Ставка в час';

  @override
  String get payFromPrevious => 'Из прошлых';

  @override
  String payPerHour(String amount) {
    return '$amount/ч';
  }

  @override
  String get perHourSuffix => '/ч';

  @override
  String payHourlyTotal(String hours, String rate, String total) {
    return '$hours × $rate = $total';
  }

  @override
  String get defaultPay => 'Оплата по умолчанию';

  @override
  String minutesShort(int m) {
    return '$m мин';
  }

  @override
  String hoursShort(int h) {
    return '$h ч';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h ч $m мин';
  }

  @override
  String hoursValue(String hours) {
    return '$hours ч';
  }

  @override
  String get attachments => 'Файлы';

  @override
  String attachmentsCount(int count, int max) {
    return '$count/$max';
  }

  @override
  String get attachPhotoVideo => 'Фото или видео';

  @override
  String get attachFile => 'Файл';

  @override
  String attachmentsLimit(int max) {
    return 'Не больше $max файлов';
  }

  @override
  String get deleteAttachment => 'Удалить файл?';

  @override
  String get openFileFailed => 'Не удалось открыть файл';

  @override
  String get deleteShiftTypeTitle => 'Удалить тип смены?';

  @override
  String get deleteShiftTypeBody => 'Все смены этого типа также будут удалены из календаря.';

  @override
  String get pickMonth => 'Выберите месяц';

  @override
  String monthRange(String from, String to) {
    return '$from - $to';
  }

  @override
  String monthsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count месяца',
      many: '$count месяцев',
      few: '$count месяца',
      one: '$count месяц',
    );
    return '$_temp0';
  }

  @override
  String get reportsTitle => 'Отчёты';

  @override
  String get earned => 'Заработано';

  @override
  String changeVsPrevMonth(int percent) {
    return '$percent% к прошлому месяцу';
  }

  @override
  String shiftsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count смены',
      many: '$count смен',
      few: '$count смены',
      one: '$count смена',
    );
    return '$_temp0';
  }

  @override
  String shiftTotals(int count, String duration) {
    return '$count× · $duration';
  }

  @override
  String eventsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count события',
      many: '$count событий',
      few: '$count события',
      one: '$count событие',
    );
    return '$_temp0';
  }

  @override
  String unpaidCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count записи без оплаты',
      many: '$count записей без оплаты',
      few: '$count записи без оплаты',
      one: '$count запись без оплаты',
    );
    return '$_temp0';
  }

  @override
  String get reportsMultiHint => 'Удерживайте месяц, чтобы добавить его в отчёт';

  @override
  String get byShiftType => 'По типам смен';

  @override
  String get events => 'События';

  @override
  String get lastMonths => 'Последние 6 месяцев';

  @override
  String get reportEmpty => 'В этом месяце пока ничего не заработано';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get firstDayOfWeek => 'Начало недели';

  @override
  String get timeFormat => 'Формат времени';

  @override
  String get timeFormat24 => '24 часа';

  @override
  String get timeFormat12 => '12 часов (AM/PM)';

  @override
  String get currency => 'Валюта';

  @override
  String get system => 'Системный';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get logs => 'Логи';

  @override
  String get notifications => 'Уведомления о напоминаниях';

  @override
  String get notificationsDenied => 'Уведомления для SShift выключены в настройках системы';

  @override
  String get remindersChannel => 'Напоминания';

  @override
  String get reminder => 'Напоминание';

  @override
  String get reminderTime => 'Время напоминания';

  @override
  String get reminderAtStart => 'В момент начала';

  @override
  String reminderMinutesBefore(int minutes) {
    return 'За $minutes мин';
  }

  @override
  String reminderHoursBefore(int hours) {
    return 'За $hours ч';
  }

  @override
  String get reminderDayBefore => 'За день';

  @override
  String get reminderOnDay => 'В день события';

  @override
  String get reminderAllDayDayBefore => 'Накануне';

  @override
  String reminderToday(String span) {
    return 'Сегодня, $span';
  }

  @override
  String reminderTomorrow(String span) {
    return 'Завтра, $span';
  }

  @override
  String reminderOnDate(String date, String span) {
    return '$date, $span';
  }

  @override
  String get autoCheckUpdates => 'Проверять обновления автоматически';

  @override
  String get checkForUpdates => 'Проверить обновления';

  @override
  String get newVersionAvailable => 'Доступна новая версия';

  @override
  String get upToDate => 'У вас последняя версия';

  @override
  String get updateCheckFailed => 'Не удалось проверить обновления';

  @override
  String updateAvailable(String version) {
    return 'Доступна версия $version';
  }

  @override
  String get updateInstalledVersion => 'Установлена версия';

  @override
  String get updateDownloadSize => 'Размер загрузки';

  @override
  String get whatsNew => 'Что нового';

  @override
  String get updateNow => 'Обновить';

  @override
  String get installUpdate => 'Установить';

  @override
  String get updateLater => 'Позже';

  @override
  String get downloadingUpdate => 'Загрузка…';

  @override
  String downloadProgress(String received, String total, int percent) {
    return '$received из $total · $percent%';
  }

  @override
  String get downloadFailed => 'Не удалось скачать обновление';

  @override
  String get installFailed => 'Не удалось открыть установщик';

  @override
  String get retry => 'Повторить';

  @override
  String megabytes(String value) {
    return '$value МБ';
  }

  @override
  String get openLinkFailed => 'Не удалось открыть ссылку';

  @override
  String get dataExport => 'Экспорт данных';

  @override
  String get dataImport => 'Импорт данных';

  @override
  String get backupShiftTypes => 'Типы смен';

  @override
  String get backupShifts => 'Смены';

  @override
  String get backupEvents => 'События';

  @override
  String get backupFiles => 'Файлы';

  @override
  String backupFilesValue(int count, String size) {
    return '$count · $size';
  }

  @override
  String get backupCreatedAt => 'Создана';

  @override
  String get backupIncludeFiles => 'Включить файлы';

  @override
  String get backupExportAction => 'Экспортировать';

  @override
  String get backupExportFailed => 'Не удалось экспортировать данные';

  @override
  String get backupImportWarning =>
      'Все текущие типы смен, смены, события и файлы будут удалены и заменены данными из копии.';

  @override
  String get backupImportAction => 'Заменить данные';

  @override
  String get backupImportDone => 'Данные импортированы';

  @override
  String get backupImportFailed => 'Не удалось импортировать данные';

  @override
  String get backupUnrecognized => 'Это не файл резервной копии SShift';

  @override
  String get backupNewerVersion => 'Копия создана более новой версией SShift. Сначала обновите приложение.';

  @override
  String get backupCorrupted => 'Файл резервной копии повреждён';

  @override
  String get backupModeMerge => 'Добавить';

  @override
  String get backupModeReplace => 'Заменить';

  @override
  String get backupMergeHint =>
      'Новые записи из копии добавятся к текущим. Записи, которые уже есть в приложении, не изменятся.';

  @override
  String get backupMergeAction => 'Импортировать';

  @override
  String backupMergeDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Добавлено $count записи',
      many: 'Добавлено $count записей',
      few: 'Добавлено $count записи',
      one: 'Добавлена $count запись',
      zero: 'Новых записей нет',
    );
    return '$_temp0';
  }

  @override
  String get dataDeleteAll => 'Удалить все данные';

  @override
  String get dataDeleteAllTitle => 'Удалить все данные?';

  @override
  String get dataDeleteAllBody =>
      'Все типы смен, смены, события и файлы будут удалены с этого устройства без возможности восстановления. Настройки останутся.';

  @override
  String get yes => 'Да';

  @override
  String yesCountdown(int seconds) {
    return 'Да ($seconds)';
  }

  @override
  String get dataDeleted => 'Все данные удалены';

  @override
  String get dataDeleteFailed => 'Не удалось удалить данные';
}
