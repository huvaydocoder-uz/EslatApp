import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../../core/l10n/app_language.dart';
import '../../profile/data/profile_repository.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';
import '../domain/auth_failure.dart';

part 'auth_controller.g.dart';

/// Kirish va chiqish amallari. Holat: yuklanmoqda / xato (AuthFailure) / tayyor.
///
/// `keepAlive` — kirish muvaffaqiyatli bo'lgach router darhol `/home` ga
/// o'tadi va kirish ekrani yopiladi; profil yaratish esa shu yerda tugaydi.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithGoogle() async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (!ref.read(firebaseReadyProvider)) {
        throw const AuthFailure(AuthFailureReason.notConfigured);
      }
      final user = await ref.read(authRepositoryProvider).signInWithGoogle();
      if (user == null) return; // foydalanuvchi oynani yopdi — xato emas
      await _ensureProfile(user);
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signOut(),
    );
  }

  /// Profil yaratilmasa ham kirish bekor qilinmaydi (masalan, internet
  /// uzildi) — sozlama birinchi marta saqlanganda profil qayta yaratiladi.
  Future<void> _ensureProfile(AppUser user) async {
    final language = AppLanguage.fromDevice(
      PlatformDispatcher.instance.locales,
    );
    try {
      await ref.read(profileRepositoryProvider).ensureProfile(user, language);
    } on Exception catch (error) {
      if (kDebugMode) debugPrint('Profil yaratilmadi: $error');
    }
  }
}
