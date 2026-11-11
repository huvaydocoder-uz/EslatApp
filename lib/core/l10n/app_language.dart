import 'dart:ui';

/// Ilova tillari. Tartibi sozlamalar ekranida shunday ko'rinadi.
///
/// Til nomlari tarjima qilinmaydi: har bir til o'z tilida yoziladi
/// (rus tilini bilmaydigan odam ham "O'zbekcha" ni taniydi).
enum AppLanguage {
  uz('uz', "O'zbekcha"),
  ru('ru', 'Русский'),
  en('en', 'English');

  const AppLanguage(this.code, this.nativeName);

  /// Firestore'dagi `users/{uid}.locale` qiymati.
  final String code;
  final String nativeName;

  Locale get locale => Locale(code);

  /// Telefon tili ilovada bo'lmasa — xalqaro foydalanuvchi uchun ingliz tili.
  static const fallback = AppLanguage.en;

  static AppLanguage fromCode(String? code) => AppLanguage.values.firstWhere(
    (language) => language.code == code,
    orElse: () => fallback,
  );

  /// Telefon tillari ro'yxatidan (afzallik tartibida) birinchi mosini oladi:
  /// masalan [kk, ru] → ru. Hech biri mos kelmasa — [fallback].
  static AppLanguage fromDevice(List<Locale>? deviceLocales) {
    for (final locale in deviceLocales ?? const <Locale>[]) {
      for (final language in AppLanguage.values) {
        if (language.code == locale.languageCode) return language;
      }
    }
    return fallback;
  }

  static List<Locale> get supportedLocales =>
      AppLanguage.values.map((language) => language.locale).toList();
}
