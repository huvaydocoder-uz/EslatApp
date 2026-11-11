import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/theme/theme_settings.dart';
import '../../profile/data/profile_repository.dart';

part 'app_preferences.g.dart';

/// Butun ilova mavzusi — foydalanuvchi profilidan (`users/{uid}.settings`).
/// Kirilmagan yoki profil hali yuklanmagan bo'lsa — standart mavzu.
@Riverpod(keepAlive: true)
ThemeSettings themeSettings(Ref ref) =>
    ThemeSettings.sanitized(ref.watch(currentProfileProvider).value?.settings);

/// Foydalanuvchi tanlagan til. `null` — telefon tili bo'yicha avtomatik.
@Riverpod(keepAlive: true)
Locale? appLocale(Ref ref) =>
    ref.watch(currentProfileProvider).value?.language.locale;
