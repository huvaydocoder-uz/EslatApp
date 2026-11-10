import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/domain/app_user.dart';
import 'app_routes.dart';

/// Kirish holatiga qarab qayerga yo'naltirishni hal qiladi.
///
/// Sof funksiya (Flutter/Firebase'siz) — unit testlar bilan to'liq
/// tekshiriladi. `null` qaytsa — joriy sahifada qolinadi.
String? authRedirect({required AsyncValue<AppUser?> auth, required Uri uri}) {
  final path = uri.path;
  final onSplash = path == AppRoutes.splash;
  final inAuthFlow = AppRoutes.isAuthFlow(path);

  // Firebase hali javob bermadi — splash'da kutamiz, asl manzilni eslab
  // qolamiz (masalan, bildirishnomadan ochilgan budilnik sahifasi).
  if (auth.isLoading && !auth.hasValue) {
    if (onSplash) return null;
    return Uri(
      path: AppRoutes.splash,
      queryParameters: {AppRoutes.fromParam: uri.toString()},
    ).toString();
  }

  // Xatolik yoki kirilmagan — kirish ekraniga.
  final signedIn = !auth.hasError && auth.value != null;
  if (!signedIn) return inAuthFlow ? null : AppRoutes.auth;

  // Kirgan foydalanuvchi splash/kirish ekranlarida qolmaydi.
  if (onSplash) {
    return _safeReturnPath(uri.queryParameters[AppRoutes.fromParam]) ??
        AppRoutes.home;
  }
  if (inAuthFlow) return AppRoutes.home;
  return null;
}

/// Faqat ilova ichidagi xavfsiz yo'lni qabul qiladi (tashqi URL emas,
/// splash/kirish sahifalariga qaytish sikli emas).
String? _safeReturnPath(String? from) {
  if (from == null || !from.startsWith('/') || from.startsWith('//')) {
    return null;
  }
  final path = Uri.tryParse(from)?.path;
  if (path == null || path == AppRoutes.splash || AppRoutes.isAuthFlow(path)) {
    return null;
  }
  return from;
}
