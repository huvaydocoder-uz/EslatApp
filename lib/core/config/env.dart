import 'package:flutter_dotenv/flutter_dotenv.dart';

/// `.env` faylidan o'qiladigan sozlamalar.
///
/// `.env` git'ga tushmaydi (.gitignore). Namuna: `.env.example`.
/// Eslatma: Firebase *client* kalitlari ilova ichiga baribir kiradi — ular
/// maxfiy emas. Haqiqiy himoya: Security Rules + App Check. Telegram bot
/// tokeni va SMS shlyuz kalitlari esa FAQAT serverda (Cloud Functions
/// Secret Manager) saqlanadi va bu faylga hech qachon yozilmaydi.
abstract final class Env {
  static const fileName = '.env';

  static Future<void> load() => dotenv.load(fileName: fileName);

  static String get firebaseProjectId => _require('FIREBASE_PROJECT_ID');
  static String get firebaseMessagingSenderId =>
      _require('FIREBASE_MESSAGING_SENDER_ID');
  static String get firebaseStorageBucket =>
      _require('FIREBASE_STORAGE_BUCKET');

  static String get firebaseAndroidApiKey =>
      _require('FIREBASE_ANDROID_API_KEY');
  static String get firebaseAndroidAppId => _require('FIREBASE_ANDROID_APP_ID');

  static String get firebaseIosApiKey => _require('FIREBASE_IOS_API_KEY');
  static String get firebaseIosAppId => _require('FIREBASE_IOS_APP_ID');
  static String get firebaseIosBundleId => _require('FIREBASE_IOS_BUNDLE_ID');
  static String? get firebaseIosClientId => _optional('FIREBASE_IOS_CLIENT_ID');

  static String? get googleServerClientId =>
      _optional('GOOGLE_SERVER_CLIENT_ID');
  static String? get telegramBotUsername => _optional('TELEGRAM_BOT_USERNAME');

  static String _require(String key) {
    final value = dotenv.maybeGet(key);
    if (value == null || value.isEmpty) {
      throw StateError(
        '.env faylida "$key" topilmadi. .env.example dan nusxa oling.',
      );
    }
    return value;
  }

  static String? _optional(String key) {
    final value = dotenv.maybeGet(key);
    return (value == null || value.isEmpty) ? null : value;
  }
}
