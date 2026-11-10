import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../domain/app_user.dart';

part 'auth_repository.g.dart';

/// Firebase Auth bilan ishlovchi yagona joy.
///
/// 1-qadamda faqat kirish holatini kuzatish va chiqish bor.
/// 2-qadamda: Google, telefon (SMS kod) va Telegram (custom token) kirishlari.
class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<AppUser?> authStateChanges() =>
      _auth.authStateChanges().map(_toAppUser);

  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  Future<void> signOut() => _auth.signOut();

  static AppUser? _toAppUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
    );
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepository(ref.watch(firebaseAuthProvider));

/// Kirish holati: `null` — kirilmagan, `AppUser` — kirgan.
@Riverpod(keepAlive: true)
Stream<AppUser?> authState(Ref ref) =>
    ref.watch(authRepositoryProvider).authStateChanges();
