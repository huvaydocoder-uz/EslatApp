/// Matn bo'lmagan umumiy konstantalar (UI matnlari `app_strings.dart` da).
abstract final class AppConstants {
  /// Standart soat mintaqasi (O'zbekiston).
  static const defaultTimezone = 'Asia/Tashkent';

  /// Eslatma standart vaqti (soat:daqiqa).
  static const defaultNotifyTime = '09:00';
}

/// Firestore kolleksiya va maydon nomlari — `firebase/firestore.rules`
/// va `docs/FIRESTORE.md` bilan bir xil bo'lishi SHART.
abstract final class FirestorePaths {
  static const users = 'users';
  static const events = 'events';
  static const devices = 'devices';
  static const smsLogs = 'smsLogs';
  static const plans = 'plans';
  static const categories = 'categories';

  static String user(String uid) => '$users/$uid';
  static String userEvents(String uid) => '$users/$uid/$events';
  static String userDevices(String uid) => '$users/$uid/$devices';
  static String userCategories(String uid) => '$users/$uid/$categories';
}

/// Firebase Storage yo'llari — `firebase/storage.rules` bilan mos.
abstract final class StoragePaths {
  static String avatar(String uid) => 'users/$uid/avatar/avatar.jpg';
  static String sound(String uid, String fileName) =>
      'users/$uid/sounds/$fileName';
}
