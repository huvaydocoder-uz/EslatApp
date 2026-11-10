/// Ilovadagi BARCHA foydalanuvchiga ko'rinadigan matnlar shu yerda.
///
/// Qoida: widget ichida qo'lda yozilgan matn bo'lmaydi — faqat `AppStrings.x`.
/// Keyinchalik rus va ingliz tillari qo'shilganda shu fayl ARB
/// (flutter gen-l10n) fayllariga ko'chiriladi.
abstract final class AppStrings {
  // --- Ilova ---
  static const appName = 'Eslat';
  static const appTagline = 'Yaqinlaringizning muhim kunlarini unutmang';

  // --- Pastki menyu (4 ta bo'lim) ---
  static const navHome = 'Asosiy';
  static const navEvents = 'Kunlar';
  static const navCalendar = 'Taqvim';
  static const navSettings = 'Sozlamalar';

  // --- Kirish ---
  static const loginTitle = 'Xush kelibsiz!';
  static const loginSubtitle = 'Davom etish uchun kirish usulini tanlang';
  static const loginWithGoogle = 'Gmail orqali kirish';
  static const loginWithPhone = 'Telefon raqam orqali';
  static const loginWithTelegram = 'Telegram orqali';
  static const phoneLoginTitle = 'Telefon raqam';
  static const telegramLoginTitle = 'Telegram orqali kirish';

  // --- Asosiy ---
  static const homeTitle = 'Bugun';
  static const homeEmptyTitle = 'Bugun muhim kun yo\'q';
  static const homeEmptyMessage =
      'Yaqinlaringizning tug\'ilgan kunlari va muhim sanalarini qo\'shing — '
      'vaqti kelganda albatta eslatamiz.';

  // --- Kunlar ---
  static const eventsTitle = 'Muhim kunlar';
  static const eventsEmptyTitle = 'Hali hech narsa qo\'shilmagan';
  static const eventsEmptyMessage =
      'Birinchi muhim kunni qo\'shish uchun pastdagi tugmani bosing.';
  static const addEvent = 'Qo\'shish';
  static const addEventTitle = 'Yangi muhim kun';
  static const editEventTitle = 'Tahrirlash';
  static const eventDetailsTitle = 'Batafsil';

  // --- Taqvim ---
  static const calendarTitle = 'Taqvim';
  static const calendarEmptyTitle = 'Bu oyda muhim kun yo\'q';
  static const calendarEmptyMessage =
      'Qo\'shilgan kunlar taqvimda belgi bilan ko\'rinadi.';

  // --- Sozlamalar ---
  static const settingsTitle = 'Sozlamalar';
  static const settingsEmptyTitle = 'Sozlamalar tayyorlanmoqda';
  static const settingsEmptyMessage =
      'Bu yerda mavzu, rang, ovoz va hisobingizni boshqarasiz.';
  static const themeModeSystem = 'Tizim bo\'yicha';
  static const themeModeLight = 'Kunduzgi';
  static const themeModeDark = 'Tungi';

  // --- Budilnik / Pro ---
  static const alarmTitle = 'Bugun muhim kun!';
  static const proTitle = 'Eslat Pro';

  // --- Umumiy holatlar (yuklanish / xatolik / bo'sh) ---
  static const loading = 'Yuklanmoqda...';
  static const errorTitle = 'Xatolik yuz berdi';
  static const errorMessage =
      'Internet aloqasini tekshirib, qaytadan urinib ko\'ring.';
  static const retry = 'Qayta urinish';
  static const comingSoon = 'Bu bo\'lim tez orada tayyor bo\'ladi';
  static const back = 'Orqaga';

  // --- Rang palitrasi nomlari (ekran o'quvchilari uchun) ---
  static const colorIndigo = 'Ko\'k-binafsha';
  static const colorBlue = 'Ko\'k';
  static const colorTeal = 'Zangori';
  static const colorGreen = 'Yashil';
  static const colorOlive = 'Zaytun';
  static const colorAmber = 'Sariq';
  static const colorOrange = 'To\'q sariq';
  static const colorCoral = 'Marjon';
  static const colorRed = 'Qizil';
  static const colorPink = 'Pushti';
  static const colorPurple = 'Binafsha';
  static const colorBrown = 'Jigarrang';
}
