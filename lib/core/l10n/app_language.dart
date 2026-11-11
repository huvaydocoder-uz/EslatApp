import 'dart:ui';

/// Ilova tillari. Tartibi tanlash ro'yxatida shunday ko'rinadi.
///
/// Til nomlari tarjima qilinmaydi: har bir til o'z tilida, bayroq bilan
/// yoziladi (rus tilini bilmaydigan odam ham "🇺🇿 O'zbekcha" ni taniydi).
enum AppLanguage {
  uz('uz', "O'zbekcha", '🇺🇿'),
  ru('ru', 'Русский', '🇷🇺'),
  en('en', 'English', '🇬🇧');

  const AppLanguage(this.code, this.nativeName, this.flag);

  /// Firestore'dagi `users/{uid}.locale` qiymati.
  final String code;
  final String nativeName;
  final String flag;

  Locale get locale => Locale(code);

  /// Ilova birinchi marta o'zbek tilida ochiladi (telefon tilidan qat'i nazar).
  static const defaultLanguage = AppLanguage.uz;

  /// Saqlangan qiymat noma'lum bo'lsa — o'zbekcha.
  static AppLanguage fromCode(String? code) => AppLanguage.values.firstWhere(
    (language) => language.code == code,
    orElse: () => defaultLanguage,
  );

  static List<Locale> get supportedLocales =>
      AppLanguage.values.map((language) => language.locale).toList();
}
