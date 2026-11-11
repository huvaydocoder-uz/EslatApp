import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// No description provided for @appName.
  ///
  /// In uz, this message translates to:
  /// **'Eslat'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In uz, this message translates to:
  /// **'Yaqinlaringizning muhim kunlarini unutmang'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In uz, this message translates to:
  /// **'Asosiy'**
  String get navHome;

  /// No description provided for @navEvents.
  ///
  /// In uz, this message translates to:
  /// **'Kunlar'**
  String get navEvents;

  /// No description provided for @navCalendar.
  ///
  /// In uz, this message translates to:
  /// **'Taqvim'**
  String get navCalendar;

  /// No description provided for @navSettings.
  ///
  /// In uz, this message translates to:
  /// **'Sozlamalar'**
  String get navSettings;

  /// No description provided for @loginTitle.
  ///
  /// In uz, this message translates to:
  /// **'Xush kelibsiz!'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In uz, this message translates to:
  /// **'Ro\'yxatdan o\'tish bepul. Kod kiritish shart emas — Google hisobingizni tanlang, xolos.'**
  String get loginSubtitle;

  /// No description provided for @loginWithGoogle.
  ///
  /// In uz, this message translates to:
  /// **'Gmail orqali kirish'**
  String get loginWithGoogle;

  /// No description provided for @loginAutoNote.
  ///
  /// In uz, this message translates to:
  /// **'Bir marta kirsangiz, keyingi safar ilova sizni o\'zi taniydi.'**
  String get loginAutoNote;

  /// No description provided for @authErrorNetwork.
  ///
  /// In uz, this message translates to:
  /// **'Internet aloqasi yo\'q. Tekshirib, qaytadan urinib ko\'ring.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorNotConfigured.
  ///
  /// In uz, this message translates to:
  /// **'Ilova hali Firebase\'ga ulanmagan. Dasturchiga murojaat qiling.'**
  String get authErrorNotConfigured;

  /// No description provided for @authErrorUnknown.
  ///
  /// In uz, this message translates to:
  /// **'Kirib bo\'lmadi. Qaytadan urinib ko\'ring.'**
  String get authErrorUnknown;

  /// No description provided for @homeTitle.
  ///
  /// In uz, this message translates to:
  /// **'Bugun'**
  String get homeTitle;

  /// No description provided for @homeEmptyTitle.
  ///
  /// In uz, this message translates to:
  /// **'Bugun muhim kun yo\'q'**
  String get homeEmptyTitle;

  /// No description provided for @homeEmptyMessage.
  ///
  /// In uz, this message translates to:
  /// **'Yaqinlaringizning tug\'ilgan kunlari va muhim sanalarini qo\'shing — vaqti kelganda albatta eslatamiz.'**
  String get homeEmptyMessage;

  /// No description provided for @eventsTitle.
  ///
  /// In uz, this message translates to:
  /// **'Muhim kunlar'**
  String get eventsTitle;

  /// No description provided for @eventsEmptyTitle.
  ///
  /// In uz, this message translates to:
  /// **'Hali hech narsa qo\'shilmagan'**
  String get eventsEmptyTitle;

  /// No description provided for @eventsEmptyMessage.
  ///
  /// In uz, this message translates to:
  /// **'Birinchi muhim kunni qo\'shish uchun pastdagi tugmani bosing.'**
  String get eventsEmptyMessage;

  /// No description provided for @addEvent.
  ///
  /// In uz, this message translates to:
  /// **'Qo\'shish'**
  String get addEvent;

  /// No description provided for @addEventTitle.
  ///
  /// In uz, this message translates to:
  /// **'Yangi muhim kun'**
  String get addEventTitle;

  /// No description provided for @editEventTitle.
  ///
  /// In uz, this message translates to:
  /// **'Tahrirlash'**
  String get editEventTitle;

  /// No description provided for @eventDetailsTitle.
  ///
  /// In uz, this message translates to:
  /// **'Batafsil'**
  String get eventDetailsTitle;

  /// No description provided for @calendarTitle.
  ///
  /// In uz, this message translates to:
  /// **'Taqvim'**
  String get calendarTitle;

  /// No description provided for @calendarEmptyTitle.
  ///
  /// In uz, this message translates to:
  /// **'Bu oyda muhim kun yo\'q'**
  String get calendarEmptyTitle;

  /// No description provided for @calendarEmptyMessage.
  ///
  /// In uz, this message translates to:
  /// **'Qo\'shilgan kunlar taqvimda belgi bilan ko\'rinadi.'**
  String get calendarEmptyMessage;

  /// No description provided for @settingsTitle.
  ///
  /// In uz, this message translates to:
  /// **'Sozlamalar'**
  String get settingsTitle;

  /// No description provided for @settingsAccount.
  ///
  /// In uz, this message translates to:
  /// **'Hisob'**
  String get settingsAccount;

  /// No description provided for @settingsPlanFree.
  ///
  /// In uz, this message translates to:
  /// **'Bepul tarif'**
  String get settingsPlanFree;

  /// No description provided for @settingsPlanPro.
  ///
  /// In uz, this message translates to:
  /// **'Pro tarif'**
  String get settingsPlanPro;

  /// No description provided for @settingsLanguage.
  ///
  /// In uz, this message translates to:
  /// **'Til'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In uz, this message translates to:
  /// **'Ko\'rinish'**
  String get settingsTheme;

  /// No description provided for @settingsColor.
  ///
  /// In uz, this message translates to:
  /// **'Asosiy rang'**
  String get settingsColor;

  /// No description provided for @settingsSaveError.
  ///
  /// In uz, this message translates to:
  /// **'Saqlab bo\'lmadi. Internetni tekshirib, qaytadan urinib ko\'ring.'**
  String get settingsSaveError;

  /// No description provided for @themeModeSystem.
  ///
  /// In uz, this message translates to:
  /// **'Tizim'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In uz, this message translates to:
  /// **'Kunduzgi'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In uz, this message translates to:
  /// **'Tungi'**
  String get themeModeDark;

  /// No description provided for @signOut.
  ///
  /// In uz, this message translates to:
  /// **'Hisobdan chiqish'**
  String get signOut;

  /// No description provided for @signOutConfirmTitle.
  ///
  /// In uz, this message translates to:
  /// **'Chiqasizmi?'**
  String get signOutConfirmTitle;

  /// No description provided for @signOutConfirmMessage.
  ///
  /// In uz, this message translates to:
  /// **'Ma\'lumotlaringiz saqlanib qoladi. Qayta kirsangiz hammasi joyida bo\'ladi.'**
  String get signOutConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilish'**
  String get cancel;

  /// No description provided for @alarmTitle.
  ///
  /// In uz, this message translates to:
  /// **'Bugun muhim kun!'**
  String get alarmTitle;

  /// No description provided for @proTitle.
  ///
  /// In uz, this message translates to:
  /// **'Eslat Pro'**
  String get proTitle;

  /// No description provided for @loading.
  ///
  /// In uz, this message translates to:
  /// **'Yuklanmoqda...'**
  String get loading;

  /// No description provided for @errorTitle.
  ///
  /// In uz, this message translates to:
  /// **'Xatolik yuz berdi'**
  String get errorTitle;

  /// No description provided for @errorMessage.
  ///
  /// In uz, this message translates to:
  /// **'Internet aloqasini tekshirib, qaytadan urinib ko\'ring.'**
  String get errorMessage;

  /// No description provided for @retry.
  ///
  /// In uz, this message translates to:
  /// **'Qayta urinish'**
  String get retry;

  /// No description provided for @comingSoon.
  ///
  /// In uz, this message translates to:
  /// **'Bu bo\'lim tez orada tayyor bo\'ladi'**
  String get comingSoon;

  /// No description provided for @colorIndigo.
  ///
  /// In uz, this message translates to:
  /// **'Ko\'k-binafsha'**
  String get colorIndigo;

  /// No description provided for @colorBlue.
  ///
  /// In uz, this message translates to:
  /// **'Ko\'k'**
  String get colorBlue;

  /// No description provided for @colorTeal.
  ///
  /// In uz, this message translates to:
  /// **'Zangori'**
  String get colorTeal;

  /// No description provided for @colorGreen.
  ///
  /// In uz, this message translates to:
  /// **'Yashil'**
  String get colorGreen;

  /// No description provided for @colorOlive.
  ///
  /// In uz, this message translates to:
  /// **'Zaytun'**
  String get colorOlive;

  /// No description provided for @colorAmber.
  ///
  /// In uz, this message translates to:
  /// **'Sariq'**
  String get colorAmber;

  /// No description provided for @colorOrange.
  ///
  /// In uz, this message translates to:
  /// **'To\'q sariq'**
  String get colorOrange;

  /// No description provided for @colorCoral.
  ///
  /// In uz, this message translates to:
  /// **'Marjon'**
  String get colorCoral;

  /// No description provided for @colorRed.
  ///
  /// In uz, this message translates to:
  /// **'Qizil'**
  String get colorRed;

  /// No description provided for @colorPink.
  ///
  /// In uz, this message translates to:
  /// **'Pushti'**
  String get colorPink;

  /// No description provided for @colorPurple.
  ///
  /// In uz, this message translates to:
  /// **'Binafsha'**
  String get colorPurple;

  /// No description provided for @colorBrown.
  ///
  /// In uz, this message translates to:
  /// **'Jigarrang'**
  String get colorBrown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

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
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
