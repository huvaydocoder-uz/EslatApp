import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'env.dart';

/// Firebase sozlamalari `.env` dan yig'iladi — kalitlar kodda yo'q.
///
/// `flutterfire configure` yaratadigan `lib/firebase_options.dart` o'rniga
/// ishlatiladi (u fayl ham .gitignore ga qo'shilgan).
abstract final class EnvFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Eslat faqat Android va iOS uchun.');
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => _android,
      TargetPlatform.iOS => _ios,
      _ => throw UnsupportedError('Eslat faqat Android va iOS uchun.'),
    };
  }

  static FirebaseOptions get _android => FirebaseOptions(
    apiKey: Env.firebaseAndroidApiKey,
    appId: Env.firebaseAndroidAppId,
    messagingSenderId: Env.firebaseMessagingSenderId,
    projectId: Env.firebaseProjectId,
    storageBucket: Env.firebaseStorageBucket,
  );

  static FirebaseOptions get _ios => FirebaseOptions(
    apiKey: Env.firebaseIosApiKey,
    appId: Env.firebaseIosAppId,
    messagingSenderId: Env.firebaseMessagingSenderId,
    projectId: Env.firebaseProjectId,
    storageBucket: Env.firebaseStorageBucket,
    iosBundleId: Env.firebaseIosBundleId,
    iosClientId: Env.firebaseIosClientId,
  );
}
