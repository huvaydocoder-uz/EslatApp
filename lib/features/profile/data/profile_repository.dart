import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../../core/l10n/app_language.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/domain/app_user.dart';
import '../domain/user_profile.dart';

part 'profile_repository.g.dart';

/// `users/{uid}` profilini o'qish va yozish.
///
/// Yoziladigan har bir maydon `firebase/firestore.rules` dagi cheklovlarga
/// mos (uzunlik, ruxsat etilgan qiymatlar) — aks holda server rad etadi.
class ProfileRepository {
  const ProfileRepository(this._db);

  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _db.doc(FirestorePaths.user(uid));

  Stream<UserProfile?> watch(String uid) => _doc(uid)
      .snapshots()
      .map((snap) => snap.exists ? UserProfile.fromJson(snap.data()!) : null);

  /// Birinchi kirishda bepul tarifli profil yaratadi; bor bo'lsa tegmaydi.
  Future<void> ensureProfile(AppUser user, AppLanguage language) async {
    final ref = _doc(user.uid);
    if ((await ref.get()).exists) return;
    final profile = UserProfile(
      displayName: _limit(user.displayName, 60),
      email: _limit(user.email, 254),
      photoUrl: _limit(user.photoUrl, 1024),
      locale: language.code,
    );
    await ref.set({
      ...profile.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateLocale(String uid, AppLanguage language) =>
      _update(uid, {'locale': language.code});

  Future<void> updateThemeMode(String uid, ThemeMode mode) =>
      _update(uid, {'settings.themeMode': mode.name});

  Future<void> updateSeedColor(String uid, Color color) =>
      _update(uid, {'settings.seedColor': color.toARGB32()});

  Future<void> _update(String uid, Map<String, Object> fields) {
    return _doc(uid)
        .update({...fields, 'updatedAt': FieldValue.serverTimestamp()});
  }

  static String? _limit(String? value, int max) {
    if (value == null || value.isEmpty) return null;
    return value.length <= max ? value : value.substring(0, max);
  }
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) =>
    ProfileRepository(ref.watch(firestoreProvider));

/// Kirgan foydalanuvchining profili (real vaqtda). Kirilmagan — `null`.
///
/// Firestore o'zgarishni avval qurilmada qo'llaydi, shuning uchun til yoki
/// rang tanlansa ekran internetni kutmasdan darhol yangilanadi.
@Riverpod(keepAlive: true)
Stream<UserProfile?> currentProfile(Ref ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(null);
  return ref.watch(profileRepositoryProvider).watch(user.uid);
}
