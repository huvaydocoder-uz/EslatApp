/// Barcha yo'llar (URL) bir joyda — `context.go(AppRoutes.home)`.
abstract final class AppRoutes {
  // --- Ochilish va kirish ---
  static const splash = '/splash';
  static const auth = '/auth';

  // --- Pastki menyu (4 ta bo'lim) ---
  static const home = '/home';
  static const events = '/events';
  static const calendar = '/calendar';
  static const settings = '/settings';

  // --- To'liq ekranli sahifalar (pastki menyu ustida ochiladi) ---
  static const eventNew = '/event/new';
  static String eventDetails(String id) => '/event/$id';
  static String eventEdit(String id) => '/event/$id/edit';
  static String alarm(String eventId) => '/alarm/$eventId';
  static const pro = '/pro';

  // --- Router uchun shablonlar (parametr nomlari) ---
  static const idParam = 'id';
  static const eventDetailsPattern = '/event/:$idParam';
  static const eventEditSegment = 'edit';
  static const alarmPattern = '/alarm/:$idParam';

  /// Splash'dan keyin qaytiladigan manzil (masalan, bildirishnomadan
  /// ochilgan budilnik sahifasi) uchun query parametr.
  static const fromParam = 'from';

  /// Kirish oqimiga tegishli yo'lmi (`/auth` yoki `/auth/...`).
  static bool isAuthFlow(String location) =>
      location == auth || location.startsWith('$auth/');
}
