import 'package:eslat/core/router/app_routes.dart';
import 'package:eslat/core/router/auth_redirect.dart';
import 'package:eslat/features/auth/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const user = AppUser(uid: 'u1');
  const loading = AsyncLoading<AppUser?>();
  const signedIn = AsyncData<AppUser?>(user);
  const signedOut = AsyncData<AppUser?>(null);
  final failed = AsyncError<AppUser?>(Exception('x'), StackTrace.empty);

  String? go(AsyncValue<AppUser?> auth, String location) =>
      authRedirect(auth: auth, uri: Uri.parse(location));

  group('yuklanish paytida', () {
    test('splash ekranida qoladi', () {
      expect(go(loading, AppRoutes.splash), isNull);
    });

    test('boshqa sahifadan splashga, asl manzilni eslab qoladi', () {
      final target = go(loading, '/alarm/abc');
      expect(target, '/splash?from=%2Falarm%2Fabc');
    });
  });

  group('kirilmagan', () {
    test('himoyalangan sahifadan kirish ekraniga', () {
      expect(go(signedOut, AppRoutes.home), AppRoutes.auth);
      expect(go(signedOut, AppRoutes.settings), AppRoutes.auth);
      expect(go(signedOut, AppRoutes.splash), AppRoutes.auth);
    });

    test('kirish oqimida qoladi', () {
      expect(go(signedOut, AppRoutes.auth), isNull);
      expect(go(signedOut, '/auth/phone'), isNull);
      expect(go(signedOut, '/auth/telegram'), isNull);
    });

    test('xatolik bo\'lsa — kirilmagan deb hisoblanadi', () {
      expect(go(failed, AppRoutes.home), AppRoutes.auth);
    });

    test('"/authx" kirish oqimi emas', () {
      expect(AppRoutes.isAuthFlow('/authx'), isFalse);
    });
  });

  group('kirgan', () {
    test('splash va kirish ekranlaridan asosiyga', () {
      expect(go(signedIn, AppRoutes.splash), AppRoutes.home);
      expect(go(signedIn, AppRoutes.auth), AppRoutes.home);
      expect(go(signedIn, '/auth/phone'), AppRoutes.home);
    });

    test('ichki sahifalarda qoladi', () {
      expect(go(signedIn, AppRoutes.events), isNull);
      expect(go(signedIn, AppRoutes.eventDetails('e1')), isNull);
    });

    test('splashdan eslab qolingan manzilga qaytadi', () {
      expect(go(signedIn, '/splash?from=%2Falarm%2Fabc'), '/alarm/abc');
    });

    test('xavfli "from" qiymatlari rad etiladi', () {
      for (final from in [
        'https://evil.com',
        '//evil.com/x',
        AppRoutes.splash,
        AppRoutes.auth,
        '/auth/phone',
        'alarm/abc',
      ]) {
        final uri = Uri(
          path: AppRoutes.splash,
          queryParameters: {AppRoutes.fromParam: from},
        );
        expect(
          authRedirect(auth: signedIn, uri: uri),
          AppRoutes.home,
          reason: from,
        );
      }
    });
  });
}
