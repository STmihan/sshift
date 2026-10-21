import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('ru')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SShift'**
  String get appTitle;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'{app} {version}'**
  String appVersion(String app, String version);

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @navShifts.
  ///
  /// In en, this message translates to:
  /// **'Shifts'**
  String get navShifts;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @shift.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get shift;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @addShift.
  ///
  /// In en, this message translates to:
  /// **'Add Shift'**
  String get addShift;

  /// No description provided for @newShift.
  ///
  /// In en, this message translates to:
  /// **'New Shift'**
  String get newShift;

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @allDay.
  ///
  /// In en, this message translates to:
  /// **'All Day'**
  String get allDay;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @nextDay.
  ///
  /// In en, this message translates to:
  /// **'(next day)'**
  String get nextDay;

  /// No description provided for @breakLabel.
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get breakLabel;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @doneCount.
  ///
  /// In en, this message translates to:
  /// **'Done ({count})'**
  String doneCount(int count);

  /// No description provided for @defaultValues.
  ///
  /// In en, this message translates to:
  /// **'Default values'**
  String get defaultValues;

  /// No description provided for @paintHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a shift and tap days'**
  String get paintHint;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @payNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get payNone;

  /// No description provided for @payFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get payFixed;

  /// No description provided for @payHourly.
  ///
  /// In en, this message translates to:
  /// **'Hourly'**
  String get payHourly;

  /// No description provided for @payAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get payAmount;

  /// No description provided for @payRate.
  ///
  /// In en, this message translates to:
  /// **'Rate per hour'**
  String get payRate;

  /// No description provided for @payFromPrevious.
  ///
  /// In en, this message translates to:
  /// **'From previous'**
  String get payFromPrevious;

  /// No description provided for @payPerHour.
  ///
  /// In en, this message translates to:
  /// **'{amount}/h'**
  String payPerHour(String amount);

  /// No description provided for @perHourSuffix.
  ///
  /// In en, this message translates to:
  /// **'/h'**
  String get perHourSuffix;

  /// No description provided for @payHourlyTotal.
  ///
  /// In en, this message translates to:
  /// **'{hours} × {rate} = {total}'**
  String payHourlyTotal(String hours, String rate, String total);

  /// No description provided for @defaultPay.
  ///
  /// In en, this message translates to:
  /// **'Default pay'**
  String get defaultPay;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{m}m'**
  String minutesShort(int m);

  /// No description provided for @hoursShort.
  ///
  /// In en, this message translates to:
  /// **'{h}h'**
  String hoursShort(int h);

  /// No description provided for @hoursMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'{h}h {m}m'**
  String hoursMinutesShort(int h, int m);

  /// No description provided for @hoursValue.
  ///
  /// In en, this message translates to:
  /// **'{hours} h'**
  String hoursValue(String hours);

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get attachments;

  /// No description provided for @attachmentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count}/{max}'**
  String attachmentsCount(int count, int max);

  /// No description provided for @attachPhotoVideo.
  ///
  /// In en, this message translates to:
  /// **'Photo or video'**
  String get attachPhotoVideo;

  /// No description provided for @attachFile.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get attachFile;

  /// No description provided for @attachmentsLimit.
  ///
  /// In en, this message translates to:
  /// **'Up to {max} files'**
  String attachmentsLimit(int max);

  /// No description provided for @deleteAttachment.
  ///
  /// In en, this message translates to:
  /// **'Delete file?'**
  String get deleteAttachment;

  /// No description provided for @openFileFailed.
  ///
  /// In en, this message translates to:
  /// **'Can\'t open the file'**
  String get openFileFailed;

  /// No description provided for @deleteShiftTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete shift type?'**
  String get deleteShiftTypeTitle;

  /// No description provided for @deleteShiftTypeBody.
  ///
  /// In en, this message translates to:
  /// **'All shifts of this type will also be removed from the calendar.'**
  String get deleteShiftTypeBody;

  /// No description provided for @pickMonth.
  ///
  /// In en, this message translates to:
  /// **'Select month'**
  String get pickMonth;

  /// No description provided for @monthRange.
  ///
  /// In en, this message translates to:
  /// **'{from} – {to}'**
  String monthRange(String from, String to);

  /// No description provided for @monthsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} month} other{{count} months}}'**
  String monthsSelected(int count);

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsTitle;

  /// No description provided for @earned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get earned;

  /// No description provided for @changeVsPrevMonth.
  ///
  /// In en, this message translates to:
  /// **'{percent}% vs last month'**
  String changeVsPrevMonth(int percent);

  /// No description provided for @shiftsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} shift} other{{count} shifts}}'**
  String shiftsCount(int count);

  /// No description provided for @shiftTotals.
  ///
  /// In en, this message translates to:
  /// **'{count}× · {duration}'**
  String shiftTotals(int count, String duration);

  /// No description provided for @eventsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} event} other{{count} events}}'**
  String eventsCount(int count);

  /// No description provided for @unpaidCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} entry without pay} other{{count} entries without pay}}'**
  String unpaidCount(int count);

  /// No description provided for @reportsMultiHint.
  ///
  /// In en, this message translates to:
  /// **'Hold a month to add it to the report'**
  String get reportsMultiHint;

  /// No description provided for @byShiftType.
  ///
  /// In en, this message translates to:
  /// **'By shift type'**
  String get byShiftType;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @lastMonths.
  ///
  /// In en, this message translates to:
  /// **'Last 6 months'**
  String get lastMonths;

  /// No description provided for @reportEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing earned this month yet'**
  String get reportEmpty;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @firstDayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'First day of week'**
  String get firstDayOfWeek;

  /// No description provided for @timeFormat.
  ///
  /// In en, this message translates to:
  /// **'Time format'**
  String get timeFormat;

  /// No description provided for @timeFormat24.
  ///
  /// In en, this message translates to:
  /// **'24-hour'**
  String get timeFormat24;

  /// No description provided for @timeFormat12.
  ///
  /// In en, this message translates to:
  /// **'12-hour (AM/PM)'**
  String get timeFormat12;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
