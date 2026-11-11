// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appName => 'Eslat';

  @override
  String get navHome => 'Asosiy';

  @override
  String get navEvents => 'Kunlar';

  @override
  String get navCalendar => 'Taqvim';

  @override
  String get navSettings => 'Sozlamalar';

  @override
  String get loginTitle => 'Xush kelibsiz!';

  @override
  String get loginSubtitle =>
      'Ro\'yxatdan o\'tish bepul. Kod kiritish shart emas — Google hisobingizni tanlang, xolos.';

  @override
  String get loginWithGoogle => 'Gmail orqali kirish';

  @override
  String get loginAutoNote =>
      'Bir marta kirsangiz, keyingi safar ilova sizni o\'zi taniydi.';

  @override
  String get authErrorNetwork =>
      'Internet aloqasi yo\'q. Tekshirib, qaytadan urinib ko\'ring.';

  @override
  String get authErrorNotConfigured =>
      'Ilova hali Firebase\'ga ulanmagan. Dasturchiga murojaat qiling.';

  @override
  String get authErrorUnknown => 'Kirib bo\'lmadi. Qaytadan urinib ko\'ring.';

  @override
  String get homeTitle => 'Bugun';

  @override
  String get homeEmptyTitle => 'Bugun muhim kun yo\'q';

  @override
  String get homeEmptyMessage =>
      'Yaqinlaringizning tug\'ilgan kunlari va muhim sanalarini qo\'shing — vaqti kelganda albatta eslatamiz.';

  @override
  String get eventsTitle => 'Muhim kunlar';

  @override
  String get eventsEmptyTitle => 'Hali hech narsa qo\'shilmagan';

  @override
  String get eventsEmptyMessage =>
      'Birinchi muhim kunni qo\'shish uchun pastdagi tugmani bosing.';

  @override
  String get addEvent => 'Qo\'shish';

  @override
  String get addEventTitle => 'Yangi muhim kun';

  @override
  String get editEventTitle => 'Tahrirlash';

  @override
  String get eventDetailsTitle => 'Batafsil';

  @override
  String get calendarTitle => 'Taqvim';

  @override
  String get settingsTitle => 'Sozlamalar';

  @override
  String get settingsPlanFree => 'Bepul tarif';

  @override
  String get settingsPlanPro => 'Pro tarif';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsTheme => 'Ko\'rinish';

  @override
  String get settingsColor => 'Asosiy rang';

  @override
  String get settingsSaveError =>
      'Saqlab bo\'lmadi. Internetni tekshirib, qaytadan urinib ko\'ring.';

  @override
  String get themeModeSystem => 'Tizim';

  @override
  String get themeModeLight => 'Kunduzgi';

  @override
  String get themeModeDark => 'Tungi';

  @override
  String get signOut => 'Hisobdan chiqish';

  @override
  String get signOutConfirmTitle => 'Chiqasizmi?';

  @override
  String get signOutConfirmMessage =>
      'Ma\'lumotlaringiz saqlanib qoladi. Qayta kirsangiz hammasi joyida bo\'ladi.';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get alarmTitle => 'Bugun muhim kun!';

  @override
  String get proTitle => 'Eslat Pro';

  @override
  String get loading => 'Yuklanmoqda...';

  @override
  String get errorTitle => 'Xatolik yuz berdi';

  @override
  String get errorMessage =>
      'Internet aloqasini tekshirib, qaytadan urinib ko\'ring.';

  @override
  String get retry => 'Qayta urinish';

  @override
  String get comingSoon => 'Bu bo\'lim tez orada tayyor bo\'ladi';

  @override
  String get colorIndigo => 'Ko\'k-binafsha';

  @override
  String get colorBlue => 'Ko\'k';

  @override
  String get colorTeal => 'Zangori';

  @override
  String get colorGreen => 'Yashil';

  @override
  String get colorOlive => 'Zaytun';

  @override
  String get colorAmber => 'Sariq';

  @override
  String get colorOrange => 'To\'q sariq';

  @override
  String get colorCoral => 'Marjon';

  @override
  String get colorRed => 'Qizil';

  @override
  String get colorPink => 'Pushti';

  @override
  String get colorPurple => 'Binafsha';

  @override
  String get colorBrown => 'Jigarrang';

  @override
  String get categoryBirthday => 'Tug\'ilgan kun';

  @override
  String get categoryAnniversary => 'To\'y kuni';

  @override
  String get categoryParentBirthday => 'Ota-ona tug\'ilgan kuni';

  @override
  String get categoryMeeting => 'Uchrashuv';

  @override
  String get categoryOther => 'Boshqa';

  @override
  String get filterAll => 'Hammasi';

  @override
  String get homeUpcomingSection => 'Yaqin 30 kun';

  @override
  String get homeNothingSoonTitle => 'Yaqin 30 kunda muhim kun yo\'q';

  @override
  String get homeNothingSoonMessage =>
      'Barcha kunlaringiz \"Kunlar\" bo\'limida.';

  @override
  String get today => 'Bugun!';

  @override
  String get tomorrow => 'Ertaga';

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kundan keyin',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kun oldin o\'tdi',
    );
    return '$_temp0';
  }

  @override
  String turnsAge(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yoshga to\'ladi',
    );
    return '$_temp0';
  }

  @override
  String anniversaryYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yillik',
    );
    return '$_temp0';
  }

  @override
  String get formTitle => 'Nomi';

  @override
  String get formTitleHint => 'Masalan: Onamning tug\'ilgan kuni';

  @override
  String get formPerson => 'Kim?';

  @override
  String get formPersonHint => 'Masalan: Onam';

  @override
  String get formChooseEmoji => 'Belgini tanlang';

  @override
  String get formDate => 'Sana';

  @override
  String get formYearUnknown => 'Yili noma\'lum';

  @override
  String get formTime => 'Vaqti';

  @override
  String get formNoTime => 'Belgilanmagan';

  @override
  String get formRepeatYearly => 'Har yili takrorlansin';

  @override
  String get formReminders => 'Qachon eslatilsin?';

  @override
  String get reminderOnDay => 'O\'sha kuni';

  @override
  String reminderDaysBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kun oldin',
    );
    return '$_temp0';
  }

  @override
  String get formRemindersLimit =>
      'Bepul tarifda 2 tagacha eslatma tanlash mumkin.';

  @override
  String get formAlarm => 'Budilnik chalsin';

  @override
  String get formAlarmHint =>
      'O\'sha kuni musiqa siz to\'xtatmaguningizcha chaladi.';

  @override
  String get formSms => 'Tabrik SMS';

  @override
  String get formPhone => 'Telefon raqami';

  @override
  String get formPhoneHint => '+998 90 123 45 67';

  @override
  String get formSmsText => 'SMS matni';

  @override
  String get formSmsTextHint => 'Tug\'ilgan kuningiz muborak!';

  @override
  String get formNote => 'Izoh';

  @override
  String get formSave => 'Saqlash';

  @override
  String get formErrorRequired => 'Bu maydonni to\'ldiring';

  @override
  String get formErrorPhone => 'Raqamni +998901234567 ko\'rinishida yozing';

  @override
  String get formErrorYear => 'Bir martalik kun uchun yilni kiriting';

  @override
  String get saveError =>
      'Saqlab bo\'lmadi. Internetni tekshirib, qaytadan urinib ko\'ring.';

  @override
  String get deleteAction => 'O\'chirish';

  @override
  String get deleteConfirmTitle => 'O\'chirilsinmi?';

  @override
  String get deleteConfirmMessage =>
      'Bu muhim kun va uning eslatmalari butunlay o\'chiriladi.';

  @override
  String get detailsNotFoundTitle => 'Bu muhim kun topilmadi';

  @override
  String get detailsNotFoundMessage => 'Ehtimol, u o\'chirilgan.';

  @override
  String get detailsReminders => 'Eslatmalar';

  @override
  String get detailsAlarmOn => 'Budilnik yoqilgan';

  @override
  String get detailsAlarmOff => 'Budilnik o\'chirilgan';

  @override
  String get calendarGoToday => 'Bugun';

  @override
  String get calendarPrevMonth => 'Oldingi oy';

  @override
  String get calendarNextMonth => 'Keyingi oy';

  @override
  String get calendarNoEventsDay => 'Bu kunda muhim kun yo\'q';

  @override
  String get demoBanner =>
      'Sinov rejimi: ma\'lumotlar ilova yopilguncha saqlanadi. Firebase ulangach hammasi bulutda saqlanadi.';

  @override
  String get demoUser => 'Sinov foydalanuvchisi';

  @override
  String get formNotifyTime => 'Eslatish vaqti';

  @override
  String get formSmsAuto => 'Tabrik SMS o\'zi yuborilsin';

  @override
  String get formSmsAutoHint =>
      'O\'sha kuni eslatish vaqtida telefoningizdan, o\'z raqamingizdan yuboriladi.';

  @override
  String get formPickContact => 'Kontaktlardan tanlash';

  @override
  String get smsPermissionDenied =>
      'SMS yuborishga ruxsat berilmadi. Uni telefon sozlamalarida yoqing.';

  @override
  String get notifySmsSent => 'Tabrik SMS yuborildi';

  @override
  String get notifySmsFailed => 'SMS yuborilmadi — o\'zingiz yuboring';

  @override
  String get detailsSmsAuto => 'SMS avtomatik yuboriladi';

  @override
  String get formNewType => 'Yangi tur';

  @override
  String get newTypeTitle => 'Yangi muhim kun turi';

  @override
  String get newTypeName => 'Tur nomi';

  @override
  String get newTypeNameHint => 'Masalan: Ish yubileyi';

  @override
  String get createAction => 'Yaratish';

  @override
  String get settingsCustomTypes => 'Mening turlarim';

  @override
  String get customTypesEmpty => 'Hali o\'z turingiz yo\'q.';

  @override
  String get deleteTypeConfirmTitle => 'Tur o\'chirilsinmi?';

  @override
  String get deleteTypeConfirmMessage =>
      'Bu turdagi kunlar o\'chmaydi — ular \"Boshqa\" turiga o\'tadi.';

  @override
  String get emojiOtherLabel => 'Boshqa emoji (klaviaturadan)';

  @override
  String get emojiOtherInvalid => 'Bitta emoji kiriting';

  @override
  String get done => 'Tayyor';
}
