import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/env.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../domain/app_user.dart';
import '../domain/auth_failure.dart';

part 'auth_repository.g.dart';

/// Firebase Auth bilan ishlovchi yagona joy.
///
/// Hozircha bitta usul — Gmail (Google). Kod kiritish yo'q: foydalanuvchi
/// Google hisobini tanlaydi, Firebase sessiyani qurilmada eslab qoladi va
/// keyingi ochilishlarda avtomatik kiradi.
class AuthRepository {
  AuthRepository({
    required this._auth,
    required this._google,
    required this._serverClientId,
  });

  final FirebaseAuth _auth;
  final GoogleSignIn _google;

  /// Google Cloud'dagi "Web client" ID — Android'da ID token olish uchun shart.
  final String? _serverClientId;

  Future<void>? _googleInit;

  Stream<AppUser?> authStateChanges() =>
      _auth.authStateChanges().map(_toAppUser);

  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  /// Gmail orqali kirish. Foydalanuvchi oynani yopsa — `null` (xato emas).
  Future<AppUser?> signInWithGoogle() async {
    if (_serverClientId == null) {
      throw const AuthFailure(AuthFailureReason.notConfigured);
    }
    try {
      await _ensureGoogleInitialized();
      final account = await _google.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        throw const AuthFailure(AuthFailureReason.notConfigured);
      }
      final result = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(idToken: idToken),
      );
      return _toAppUser(result.user);
    } on GoogleSignInException catch (e) {
      return switch (e.code) {
        GoogleSignInExceptionCode.canceled ||
        GoogleSignInExceptionCode.interrupted => null,
        GoogleSignInExceptionCode.clientConfigurationError ||
        GoogleSignInExceptionCode.providerConfigurationError =>
          throw const AuthFailure(AuthFailureReason.notConfigured),
        _ => throw const AuthFailure(AuthFailureReason.unknown),
      };
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(
        e.code == 'network-request-failed'
            ? AuthFailureReason.network
            : AuthFailureReason.unknown,
      );
    }
  }

  /// Chiqish: Firebase sessiyasi va Google tanlovi tozalanadi — keyingi
  /// kirishda boshqa hisobni tanlash mumkin bo'ladi.
  Future<void> signOut() async {
    await _auth.signOut();
    if (_serverClientId == null) return;
    try {
      await _ensureGoogleInitialized();
      await _google.signOut();
    } on Exception {
      // Google tomonidagi chiqish muhim emas: Firebase sessiyasi yopildi.
    }
  }

  Future<void> _ensureGoogleInitialized() {
    return _googleInit ??= _google
        .initialize(serverClientId: _serverClientId)
        .catchError((Object error, StackTrace stack) {
          _googleInit = null; // keyingi urinishda qayta initsializatsiya
          Error.throwWithStackTrace(error, stack);
        });
  }

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
GoogleSignIn googleSignIn(Ref ref) => GoogleSignIn.instance;

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepository(
  auth: ref.watch(firebaseAuthProvider),
  google: ref.watch(googleSignInProvider),
  serverClientId: Env.googleServerClientId,
);

/// Kirish holati: `null` — kirilmagan, `AppUser` — kirgan.
@Riverpod(keepAlive: true)
Stream<AppUser?> authState(Ref ref) {
  if (!ref.watch(firebaseReadyProvider)) return Stream.value(null);
  return ref.watch(authRepositoryProvider).authStateChanges();
}
