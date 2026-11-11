import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/l10n/app_language.dart';
import '../../../core/theme/theme_settings.dart';
import '../../auth/data/auth_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../data/app_preferences.dart';

part 'settings_controller.g.dart';

/// Sozlamalarni saqlash: til, kunduzgi/tungi rejim, asosiy rang.
///
/// Firestore o'zgarishni avval qurilmada qo'llaydi — ekran darhol yangilanadi,
/// internet bo'lmasa ham. Xatolik (masalan, ruxsat yo'q) holatda `AsyncError`.
@riverpod
class SettingsController extends _$SettingsController {
  @override
  FutureOr<void> build() {}

  Future<void> setLanguage(AppLanguage language) {
    ref.read(languageChoiceProvider.notifier).choose(language);
    return _save((repo, uid) => repo.updateLocale(uid, language));
  }

  Future<void> setThemeMode(ThemeMode mode) =>
      _save((repo, uid) => repo.updateThemeMode(uid, mode));

  Future<void> setSeedColor(Color color) async {
    if (!ThemeSettings.isAllowedSeed(color)) return;
    await _save((repo, uid) => repo.updateSeedColor(uid, color));
  }

  Future<void> _save(
    Future<void> Function(ProfileRepository repo, String uid) action,
  ) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    final repo = ref.read(profileRepositoryProvider);
    final hasProfile = ref.read(currentProfileProvider).value != null;

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      if (!hasProfile) {
        final language = ref.read(appLanguageProvider);
        await repo.ensureProfile(user, language);
      }
      await action(repo, user.uid);
    });
    if (ref.mounted) state = result;
  }
}
