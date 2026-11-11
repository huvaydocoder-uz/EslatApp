import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/l10n/app_language.dart';
import '../../../core/theme/theme_settings.dart';
import '../../profile/data/profile_repository.dart';

part 'app_preferences.g.dart';

/// Butun ilova mavzusi — foydalanuvchi profilidan (`users/{uid}.settings`).
/// Kirilmagan yoki profil hali yuklanmagan bo'lsa — standart mavzu.
@Riverpod(keepAlive: true)
ThemeSettings themeSettings(Ref ref) =>
    ThemeSettings.sanitized(ref.watch(currentProfileProvider).value?.settings);

/// Kirishdan oldin (kirish ekranida) tanlangan til. Kirgach profilga yoziladi.
@Riverpod(keepAlive: true)
class LanguageChoice extends _$LanguageChoice {
  @override
  AppLanguage? build() => null;

  void choose(AppLanguage language) => state = language;
}

/// Ekrandagi til: profildagi → kirishdan oldin tanlangan → o'zbekcha.
@Riverpod(keepAlive: true)
AppLanguage appLanguage(Ref ref) {
  final saved = ref.watch(currentProfileProvider).value?.language;
  return saved ??
      ref.watch(languageChoiceProvider) ??
      AppLanguage.defaultLanguage;
}

@Riverpod(keepAlive: true)
Locale appLocale(Ref ref) => ref.watch(appLanguageProvider).locale;
