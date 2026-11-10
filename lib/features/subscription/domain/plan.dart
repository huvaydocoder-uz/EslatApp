/// Tarif rejalari.
///
/// Foydalanuvchi tarifi `users/{uid}.plan` maydonida saqlanadi va uni FAQAT
/// server (Cloud Functions, to'lov tasdiqlangandan keyin) o'zgartiradi —
/// Security Rules mijozga bu maydonni yozishni taqiqlaydi.
enum AppPlan {
  free,
  pro;

  static AppPlan fromName(String? name) => AppPlan.values.firstWhere(
    (plan) => plan.name == name,
    orElse: () => AppPlan.free,
  );
}

/// Tarifga qarab nimalarga ruxsat borligi.
///
/// UI va providerlar `plan == AppPlan.pro` deb tekshirmaydi — faqat shu
/// klassdan so'raydi. Yangi tarif (masalan, "Oila") qo'shilsa, faqat shu
/// fayl o'zgaradi. Server tomonda ham xuddi shu cheklovlar tekshiriladi.
class Entitlements {
  const Entitlements._({
    required this.maxRemindersPerEvent,
    required this.autoSms,
    required this.customAlarmSound,
    required this.telegramReminders,
  });

  factory Entitlements.of(AppPlan plan) => switch (plan) {
    AppPlan.free => _free,
    AppPlan.pro => _pro,
  };

  /// Bitta kun uchun nechta eslatma (masalan: o'sha kuni + 1 kun oldin).
  final int maxRemindersPerEvent;

  /// SMS server orqali avtomatik yuboriladi (bepulda — 1 bosishda o'zi yuboradi).
  final bool autoSms;

  /// O'z musiqasini budilnik ovozi qilib yuklash.
  final bool customAlarmSound;

  /// Eslatmani Telegram bot orqali ham olish.
  final bool telegramReminders;

  static const _free = Entitlements._(
    maxRemindersPerEvent: 2,
    autoSms: false,
    customAlarmSound: false,
    telegramReminders: false,
  );

  static const _pro = Entitlements._(
    maxRemindersPerEvent: 5,
    autoSms: true,
    customAlarmSound: true,
    telegramReminders: true,
  );
}
