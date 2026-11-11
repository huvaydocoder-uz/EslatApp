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

  /// No description provided for @settingsTitle.
  ///
  /// In uz, this message translates to:
  /// **'Sozlamalar'**
  String get settingsTitle;

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

  /// No description provided for @categoryBirthday.
  ///
  /// In uz, this message translates to:
  /// **'Tug\'ilgan kun'**
  String get categoryBirthday;

  /// No description provided for @categoryAnniversary.
  ///
  /// In uz, this message translates to:
  /// **'To\'y kuni'**
  String get categoryAnniversary;

  /// No description provided for @categoryParentBirthday.
  ///
  /// In uz, this message translates to:
  /// **'Ota-ona tug\'ilgan kuni'**
  String get categoryParentBirthday;

  /// No description provided for @categoryMeeting.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuv'**
  String get categoryMeeting;

  /// No description provided for @categoryOther.
  ///
  /// In uz, this message translates to:
  /// **'Boshqa'**
  String get categoryOther;

  /// No description provided for @filterAll.
  ///
  /// In uz, this message translates to:
  /// **'Hammasi'**
  String get filterAll;

  /// No description provided for @homeUpcomingSection.
  ///
  /// In uz, this message translates to:
  /// **'Yaqin 30 kun'**
  String get homeUpcomingSection;

  /// No description provided for @homeNothingSoonTitle.
  ///
  /// In uz, this message translates to:
  /// **'Yaqin 30 kunda muhim kun yo\'q'**
  String get homeNothingSoonTitle;

  /// No description provided for @homeNothingSoonMessage.
  ///
  /// In uz, this message translates to:
  /// **'Barcha kunlaringiz \"Kunlar\" bo\'limida.'**
  String get homeNothingSoonMessage;

  /// No description provided for @today.
  ///
  /// In uz, this message translates to:
  /// **'Bugun!'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In uz, this message translates to:
  /// **'Ertaga'**
  String get tomorrow;

  /// No description provided for @daysLeft.
  ///
  /// In uz, this message translates to:
  /// **'{count, plural, other{{count} kundan keyin}}'**
  String daysLeft(int count);

  /// No description provided for @daysAgo.
  ///
  /// In uz, this message translates to:
  /// **'{count, plural, other{{count} kun oldin o\'tdi}}'**
  String daysAgo(int count);

  /// No description provided for @turnsAge.
  ///
  /// In uz, this message translates to:
  /// **'{count, plural, other{{count} yoshga to\'ladi}}'**
  String turnsAge(int count);

  /// No description provided for @anniversaryYears.
  ///
  /// In uz, this message translates to:
  /// **'{count, plural, other{{count} yillik}}'**
  String anniversaryYears(int count);

  /// No description provided for @formTitle.
  ///
  /// In uz, this message translates to:
  /// **'Nomi'**
  String get formTitle;

  /// No description provided for @formTitleHint.
  ///
  /// In uz, this message translates to:
  /// **'Masalan: Onamning tug\'ilgan kuni'**
  String get formTitleHint;

  /// No description provided for @formPerson.
  ///
  /// In uz, this message translates to:
  /// **'Kim?'**
  String get formPerson;

  /// No description provided for @formPersonHint.
  ///
  /// In uz, this message translates to:
  /// **'Masalan: Onam'**
  String get formPersonHint;

  /// No description provided for @formChooseEmoji.
  ///
  /// In uz, this message translates to:
  /// **'Belgini tanlang'**
  String get formChooseEmoji;

  /// No description provided for @formDate.
  ///
  /// In uz, this message translates to:
  /// **'Sana'**
  String get formDate;

  /// No description provided for @formYearUnknown.
  ///
  /// In uz, this message translates to:
  /// **'Yili noma\'lum'**
  String get formYearUnknown;

  /// No description provided for @formTime.
  ///
  /// In uz, this message translates to:
  /// **'Vaqti'**
  String get formTime;

  /// No description provided for @formNoTime.
  ///
  /// In uz, this message translates to:
  /// **'Belgilanmagan'**
  String get formNoTime;

  /// No description provided for @formRepeatYearly.
  ///
  /// In uz, this message translates to:
  /// **'Har yili takrorlansin'**
  String get formRepeatYearly;

  /// No description provided for @formReminders.
  ///
  /// In uz, this message translates to:
  /// **'Qachon eslatilsin?'**
  String get formReminders;

  /// No description provided for @reminderOnDay.
  ///
  /// In uz, this message translates to:
  /// **'O\'sha kuni'**
  String get reminderOnDay;

  /// No description provided for @reminderDaysBefore.
  ///
  /// In uz, this message translates to:
  /// **'{count, plural, other{{count} kun oldin}}'**
  String reminderDaysBefore(int count);

  /// No description provided for @formRemindersLimit.
  ///
  /// In uz, this message translates to:
  /// **'Bepul tarifda 2 tagacha eslatma tanlash mumkin.'**
  String get formRemindersLimit;

  /// No description provided for @formAlarm.
  ///
  /// In uz, this message translates to:
  /// **'Budilnik chalsin'**
  String get formAlarm;

  /// No description provided for @formAlarmHint.
  ///
  /// In uz, this message translates to:
  /// **'O\'sha kuni musiqa siz to\'xtatmaguningizcha chaladi.'**
  String get formAlarmHint;

  /// No description provided for @formSms.
  ///
  /// In uz, this message translates to:
  /// **'Tabrik SMS'**
  String get formSms;

  /// No description provided for @formPhone.
  ///
  /// In uz, this message translates to:
  /// **'Telefon raqami'**
  String get formPhone;

  /// No description provided for @formPhoneHint.
  ///
  /// In uz, this message translates to:
  /// **'+998 90 123 45 67'**
  String get formPhoneHint;

  /// No description provided for @formSmsText.
  ///
  /// In uz, this message translates to:
  /// **'SMS matni'**
  String get formSmsText;

  /// No description provided for @formSmsTextHint.
  ///
  /// In uz, this message translates to:
  /// **'Tug\'ilgan kuningiz muborak!'**
  String get formSmsTextHint;

  /// No description provided for @formNote.
  ///
  /// In uz, this message translates to:
  /// **'Izoh'**
  String get formNote;

  /// No description provided for @formSave.
  ///
  /// In uz, this message translates to:
  /// **'Saqlash'**
  String get formSave;

  /// No description provided for @formErrorRequired.
  ///
  /// In uz, this message translates to:
  /// **'Bu maydonni to\'ldiring'**
  String get formErrorRequired;

  /// No description provided for @formErrorPhone.
  ///
  /// In uz, this message translates to:
  /// **'Raqamni +998901234567 ko\'rinishida yozing'**
  String get formErrorPhone;

  /// No description provided for @formErrorYear.
  ///
  /// In uz, this message translates to:
  /// **'Bir martalik kun uchun yilni kiriting'**
  String get formErrorYear;

  /// No description provided for @saveError.
  ///
  /// In uz, this message translates to:
  /// **'Saqlab bo\'lmadi. Internetni tekshirib, qaytadan urinib ko\'ring.'**
  String get saveError;

  /// No description provided for @deleteAction.
  ///
  /// In uz, this message translates to:
  /// **'O\'chirish'**
  String get deleteAction;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In uz, this message translates to:
  /// **'O\'chirilsinmi?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmMessage.
  ///
  /// In uz, this message translates to:
  /// **'Bu muhim kun va uning eslatmalari butunlay o\'chiriladi.'**
  String get deleteConfirmMessage;

  /// No description provided for @detailsNotFoundTitle.
  ///
  /// In uz, this message translates to:
  /// **'Bu muhim kun topilmadi'**
  String get detailsNotFoundTitle;

  /// No description provided for @detailsNotFoundMessage.
  ///
  /// In uz, this message translates to:
  /// **'Ehtimol, u o\'chirilgan.'**
  String get detailsNotFoundMessage;

  /// No description provided for @detailsReminders.
  ///
  /// In uz, this message translates to:
  /// **'Eslatmalar'**
  String get detailsReminders;

  /// No description provided for @detailsAlarmOn.
  ///
  /// In uz, this message translates to:
  /// **'Budilnik yoqilgan'**
  String get detailsAlarmOn;

  /// No description provided for @detailsAlarmOff.
  ///
  /// In uz, this message translates to:
  /// **'Budilnik o\'chirilgan'**
  String get detailsAlarmOff;

  /// No description provided for @calendarGoToday.
  ///
  /// In uz, this message translates to:
  /// **'Bugun'**
  String get calendarGoToday;

  /// No description provided for @calendarPrevMonth.
  ///
  /// In uz, this message translates to:
  /// **'Oldingi oy'**
  String get calendarPrevMonth;

  /// No description provided for @calendarNextMonth.
  ///
  /// In uz, this message translates to:
  /// **'Keyingi oy'**
  String get calendarNextMonth;

  /// No description provided for @calendarNoEventsDay.
  ///
  /// In uz, this message translates to:
  /// **'Bu kunda muhim kun yo\'q'**
  String get calendarNoEventsDay;

  /// No description provided for @demoBanner.
  ///
  /// In uz, this message translates to:
  /// **'Sinov rejimi: ma\'lumotlar ilova yopilguncha saqlanadi. Firebase ulangach hammasi bulutda saqlanadi.'**
  String get demoBanner;

  /// No description provided for @demoUser.
  ///
  /// In uz, this message translates to:
  /// **'Sinov foydalanuvchisi'**
  String get demoUser;

  /// No description provided for @formNotifyTime.
  ///
  /// In uz, this message translates to:
  /// **'Eslatish vaqti'**
  String get formNotifyTime;

  /// No description provided for @formSmsAuto.
  ///
  /// In uz, this message translates to:
  /// **'Tabrik SMS o\'zi yuborilsin'**
  String get formSmsAuto;

  /// No description provided for @formSmsAutoHint.
  ///
  /// In uz, this message translates to:
  /// **'O\'sha kuni eslatish vaqtida telefoningizdan, o\'z raqamingizdan yuboriladi.'**
  String get formSmsAutoHint;

  /// No description provided for @formPickContact.
  ///
  /// In uz, this message translates to:
  /// **'Kontaktlardan tanlash'**
  String get formPickContact;

  /// No description provided for @smsPermissionDenied.
  ///
  /// In uz, this message translates to:
  /// **'SMS yuborishga ruxsat berilmadi. Uni telefon sozlamalarida yoqing.'**
  String get smsPermissionDenied;

  /// No description provided for @notifySmsSent.
  ///
  /// In uz, this message translates to:
  /// **'Tabrik SMS yuborildi'**
  String get notifySmsSent;

  /// No description provided for @notifySmsFailed.
  ///
  /// In uz, this message translates to:
  /// **'SMS yuborilmadi — o\'zingiz yuboring'**
  String get notifySmsFailed;

  /// No description provided for @detailsSmsAuto.
  ///
  /// In uz, this message translates to:
  /// **'SMS avtomatik yuboriladi'**
  String get detailsSmsAuto;

  /// No description provided for @formNewType.
  ///
  /// In uz, this message translates to:
  /// **'Yangi tur'**
  String get formNewType;

  /// No description provided for @newTypeTitle.
  ///
  /// In uz, this message translates to:
  /// **'Yangi muhim kun turi'**
  String get newTypeTitle;

  /// No description provided for @newTypeName.
  ///
  /// In uz, this message translates to:
  /// **'Tur nomi'**
  String get newTypeName;

  /// No description provided for @newTypeNameHint.
  ///
  /// In uz, this message translates to:
  /// **'Masalan: Ish yubileyi'**
  String get newTypeNameHint;

  /// No description provided for @createAction.
  ///
  /// In uz, this message translates to:
  /// **'Yaratish'**
  String get createAction;

  /// No description provided for @settingsCustomTypes.
  ///
  /// In uz, this message translates to:
  /// **'Mening turlarim'**
  String get settingsCustomTypes;

  /// No description provided for @customTypesEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Hali o\'z turingiz yo\'q.'**
  String get customTypesEmpty;

  /// No description provided for @deleteTypeConfirmTitle.
  ///
  /// In uz, this message translates to:
  /// **'Tur o\'chirilsinmi?'**
  String get deleteTypeConfirmTitle;

  /// No description provided for @deleteTypeConfirmMessage.
  ///
  /// In uz, this message translates to:
  /// **'Bu turdagi kunlar o\'chmaydi — ular \"Boshqa\" turiga o\'tadi.'**
  String get deleteTypeConfirmMessage;

  /// No description provided for @emojiOtherLabel.
  ///
  /// In uz, this message translates to:
  /// **'Boshqa emoji (klaviaturadan)'**
  String get emojiOtherLabel;

  /// No description provided for @emojiOtherInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Bitta emoji kiriting'**
  String get emojiOtherInvalid;

  /// No description provided for @done.
  ///
  /// In uz, this message translates to:
  /// **'Tayyor'**
  String get done;
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
