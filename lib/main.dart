import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'app.dart';
import 'core/config/env.dart';
import 'core/config/firebase_options.dart';
import 'core/firebase/firebase_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();

  // .env to'ldirilmagan bo'lsa ham ilova ochiladi (yiqilmaydi):
  // kirish tugmasi bosilganda "Firebase'ga ulanmagan" xabari chiqadi.
  final firebaseReady = EnvFirebaseOptions.isConfigured;
  if (firebaseReady) {
    await Firebase.initializeApp(options: EnvFirebaseOptions.currentPlatform);
  }

  runApp(
    ProviderScope(
      overrides: [
        if (!firebaseReady) firebaseReadyProvider.overrideWithValue(false),
      ],
      child: const EslatApp(),
    ),
  );
}
