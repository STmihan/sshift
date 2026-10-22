// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SShift';

  @override
  String appVersion(String app, String version) {
    return '$app $version';
  }

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navReports => 'Reports';

  @override
  String get navShifts => 'Shifts';

  @override
  String get navSettings => 'Settings';

  @override
  String get shift => 'Shift';

  @override
  String get event => 'Event';

  @override
  String get addShift => 'Add Shift';

  @override
  String get newShift => 'New Shift';

  @override
  String get untitled => 'Untitled';

  @override
  String get title => 'Title';

  @override
  String get icon => 'Icon';

  @override
  String get color => 'Color';

  @override
  String get allDay => 'All Day';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get nextDay => '(next day)';

  @override
  String get breakLabel => 'Break';

  @override
  String get none => 'None';

  @override
  String get notes => 'Notes';

  @override
  String get location => 'Location';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get today => 'Today';

  @override
  String doneCount(int count) {
    return 'Done ($count)';
  }

  @override
  String get defaultValues => 'Default values';

  @override
  String get paintHint => 'Pick a shift and tap days';

  @override
  String get pay => 'Pay';

  @override
  String get payNone => 'None';

  @override
  String get payFixed => 'Fixed';

  @override
  String get payHourly => 'Hourly';

  @override
  String get payAmount => 'Amount';

  @override
  String get payRate => 'Rate per hour';

  @override
  String get payFromPrevious => 'From previous';

  @override
  String payPerHour(String amount) {
    return '$amount/h';
  }

  @override
  String get perHourSuffix => '/h';

  @override
  String payHourlyTotal(String hours, String rate, String total) {
    return '$hours × $rate = $total';
  }

  @override
  String get defaultPay => 'Default pay';

  @override
  String minutesShort(int m) {
    return '${m}m';
  }

  @override
  String hoursShort(int h) {
    return '${h}h';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '${h}h ${m}m';
  }

  @override
  String hoursValue(String hours) {
    return '$hours h';
  }

  @override
  String get attachments => 'Files';

  @override
  String attachmentsCount(int count, int max) {
    return '$count/$max';
  }

  @override
  String get attachPhotoVideo => 'Photo or video';

  @override
  String get attachFile => 'File';

  @override
  String attachmentsLimit(int max) {
    return 'Up to $max files';
  }

  @override
  String get deleteAttachment => 'Delete file?';

  @override
  String get openFileFailed => 'Can\'t open the file';

  @override
  String get deleteShiftTypeTitle => 'Delete shift type?';

  @override
  String get deleteShiftTypeBody => 'All shifts of this type will also be removed from the calendar.';

  @override
  String get pickMonth => 'Select month';

  @override
  String monthRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String monthsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '$count month',
    );
    return '$_temp0';
  }

  @override
  String get reportsTitle => 'Reports';

  @override
  String get earned => 'Earned';

  @override
  String changeVsPrevMonth(int percent) {
    return '$percent% vs last month';
  }

  @override
  String shiftsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shifts',
      one: '$count shift',
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
      other: '$count events',
      one: '$count event',
    );
    return '$_temp0';
  }

  @override
  String unpaidCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entries without pay',
      one: '$count entry without pay',
    );
    return '$_temp0';
  }

  @override
  String get reportsMultiHint => 'Hold a month to add it to the report';

  @override
  String get byShiftType => 'By shift type';

  @override
  String get events => 'Events';

  @override
  String get lastMonths => 'Last 6 months';

  @override
  String get reportEmpty => 'Nothing earned this month yet';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get firstDayOfWeek => 'First day of week';

  @override
  String get timeFormat => 'Time format';

  @override
  String get timeFormat24 => '24-hour';

  @override
  String get timeFormat12 => '12-hour (AM/PM)';

  @override
  String get currency => 'Currency';

  @override
  String get system => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get logs => 'Logs';

  @override
  String get autoCheckUpdates => 'Check for updates automatically';

  @override
  String get checkForUpdates => 'Check for updates';

  @override
  String get upToDate => 'You have the latest version';

  @override
  String get updateCheckFailed => 'Couldn\'t check for updates';

  @override
  String updateAvailable(String version) {
    return 'Version $version is available';
  }

  @override
  String get updateInstalledVersion => 'Installed version';

  @override
  String get updateDownloadSize => 'Download size';

  @override
  String get whatsNew => 'What\'s new';

  @override
  String get updateNow => 'Update';

  @override
  String get updateLater => 'Later';

  @override
  String get skipVersion => 'Skip version';

  @override
  String get downloadingUpdate => 'Downloading…';

  @override
  String downloadProgress(String received, String total, int percent) {
    return '$received of $total · $percent%';
  }

  @override
  String get downloadFailed => 'Couldn\'t download the update';

  @override
  String get installFailed => 'Couldn\'t open the installer';

  @override
  String get retry => 'Retry';

  @override
  String megabytes(String value) {
    return '$value MB';
  }

  @override
  String get openLinkFailed => 'Can\'t open the link';
}
