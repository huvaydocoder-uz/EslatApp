import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../../core/l10n/app_language.dart';
import '../../../core/utils/live_value.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/domain/app_user.dart';
import '../domain/user_profile.dart';

part 'profile_repository.g.dart';

/// `users/{uid}` profilini o'qish va yozish.
abstract interface class ProfileRepository {
  Stream<UserProfile?> watch(String uid);

  /// Birinchi kirishda bepul tarifli profil yaratadi; bor bo'lsa tegmaydi.
  Future<void> ensureProfile(AppUser user, AppLanguage language);

  Future<void> updateLocale(String uid, AppLanguage language);
  Future<void> updateThemeMode(String uid, ThemeMode mode);
  Future<void> updateSeedColor(String uid, Color color);
}

/// Firestore. Yoziladigan har bir maydon `firebase/firestore.rules` dagi
/// cheklovlarga mos (uzunlik, ruxsat etilgan qiymatlar).
class FirestoreProfileRepository implements ProfileRepository {
  const FirestoreProfileRepository(this._db);

  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _db.doc(FirestorePaths.user(uid));

  @override
  Stream<UserProfile?> watch(String uid) => _doc(uid)
      .snapshots()
      .map((snap) => snap.exists ? UserProfile.fromJson(snap.data()!) : null);

  @override
  Future<void> ensureProfile(AppUser user, AppLanguage language) async {
    final ref = _doc(user.uid);
    if ((await ref.get()).exists) return;
    await ref.set({
      ...newProfile(user, language).toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateLocale(String uid, AppLanguage language) =>
      _update(uid, {'locale': language.code});

  @override
  Future<void> updateThemeMode(String uid, ThemeMode mode) =>
      _update(uid, {'settings.themeMode': mode.name});

  @override
  Future<void> updateSeedColor(String uid, Color color) =>
      _update(uid, {'settings.seedColor': color.toARGB32()});

  Future<void> _update(String uid, Map<String, Object> fields) {
    return _doc(uid)
        .update({...fields, 'updatedAt': FieldValue.serverTimestamp()});
  }
}

/// Sinov rejimi: profil faqat xotirada (ilova yopilguncha).
class InMemoryProfileRepository implements ProfileRepository {
  final _profiles = <String, UserProfile>{};
  final _changes = StreamController<String>.broadcast();

  @override
  Stream<UserProfile?> watch(String uid) =>
      liveValue(() => _profiles[uid], _changes.stream.where((id) => id == uid));

  @override
  Future<void> ensureProfile(AppUser user, AppLanguage language) async {
    _profiles.putIfAbsent(user.uid, () => newProfile(user, language));
    _changes.add(user.uid);
  }

  @override
  Future<void> updateLocale(String uid, AppLanguage language) async =>
      _edit(uid, (p) => p.copyWith(locale: language.code));

  @override
  Future<void> updateThemeMode(String uid, ThemeMode mode) async => _edit(
    uid,
    (p) => p.copyWith(settings: p.settings.copyWith(themeMode: mode)),
  );

  @override
  Future<void> updateSeedColor(String uid, Color color) async => _edit(
    uid,
    (p) => p.copyWith(
      settings: p.settings.copyWith(seedColorValue: color.toARGB32()),
    ),
  );

  void _edit(String uid, UserProfile Function(UserProfile) change) {
    _profiles[uid] = change(_profiles[uid] ?? const UserProfile());
    _changes.add(uid);
  }
}

/// Yangi profil: Firestore qoidasidagi uzunlik chegaralariga moslab.
UserProfile newProfile(AppUser user, AppLanguage language) => UserProfile(
  displayName: _limit(user.displayName, 60),
  email: _limit(user.email, 254),
  photoUrl: _limit(user.photoUrl, 1024),
  locale: language.code,
);

String? _limit(String? value, int max) {
  if (value == null || value.isEmpty) return null;
  return value.length <= max ? value : value.substring(0, max);
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  if (!ref.watch(firebaseReadyProvider)) return InMemoryProfileRepository();
  return FirestoreProfileRepository(ref.watch(firestoreProvider));
}

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
