import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'theme_settings.dart';

part 'theme_controller.g.dart';

/// Mavzu holati (kunduzgi/tungi rejim va asosiy rang).
///
/// Butun ilova shu providerni kuzatadi — rang o'zgarishi bilan barcha
/// ekranlar darhol qayta chiziladi. 2-qadamda tanlov Firestore'dagi
/// `users/{uid}.settings` ga saqlanadi va qurilmalar o'rtasida sinxronlanadi.
@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeSettings build() => ThemeSettings.defaults;

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void setSeedColor(Color color) {
    if (!ThemeSettings.isAllowedSeed(color)) return;
    state = state.copyWith(seedColorValue: color.toARGB32());
  }

  /// Firestore'dan kelgan saqlangan sozlamani qo'llash.
  /// Palitrada yo'q rang kelsa (eski versiya yoki buzilgan ma'lumot),
  /// standart rang qo'yiladi.
  void restore(ThemeSettings settings) {
    state = ThemeSettings.isAllowedSeed(settings.seedColor)
        ? settings
        : settings.copyWith(
            seedColorValue: ThemeSettings.defaults.seedColorValue,
          );
  }
}
