import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart';

import 'app_palette.dart';

part 'theme_settings.freezed.dart';
part 'theme_settings.g.dart';

/// Foydalanuvchining mavzu tanlovi.
///
/// Firestore'da `users/{uid}.settings` ichida saqlanadi:
/// `{ themeMode: 'system' | 'light' | 'dark', seedColor: 0xFF3F51B5 }`.
@freezed
abstract class ThemeSettings with _$ThemeSettings {
  const ThemeSettings._();

  const factory ThemeSettings({
    @JsonKey(unknownEnumValue: ThemeMode.system)
    @Default(ThemeMode.system)
    ThemeMode themeMode,
    @JsonKey(name: 'seedColor')
    @Default(AppPalette.defaultSeedValue)
    int seedColorValue,
  }) = _ThemeSettings;

  factory ThemeSettings.fromJson(Map<String, dynamic> json) =>
      _$ThemeSettingsFromJson(json);

  static const ThemeSettings defaults = ThemeSettings();

  Color get seedColor => Color(seedColorValue);

  /// Palitradagi rang tanlanganmi (UI'da belgi qo'yish uchun).
  bool isSelected(Color color) => color.toARGB32() == seedColorValue;

  /// Xavfsizlik uchun: faqat palitradagi ranglar qabul qilinadi.
  static bool isAllowedSeed(Color color) =>
      AppPalette.colors.any((c) => c.color.toARGB32() == color.toARGB32());

  /// Saqlangan sozlamani tekshirib qaytaradi: yo'q bo'lsa — standart,
  /// palitrada yo'q rang (eski versiya / buzilgan ma'lumot) — standart rang.
  static ThemeSettings sanitized(ThemeSettings? saved) {
    if (saved == null) return defaults;
    if (isAllowedSeed(saved.seedColor)) return saved;
    return saved.copyWith(seedColorValue: AppPalette.defaultSeedValue);
  }
}
