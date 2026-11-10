import 'package:eslat/app.dart';
import 'package:eslat/core/constants/app_strings.dart';
import 'package:eslat/features/auth/data/auth_repository.dart';
import 'package:eslat/features/auth/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _app(AppUser? user) => ProviderScope(
  overrides: [authStateProvider.overrideWith((ref) => Stream.value(user))],
  child: const EslatApp(),
);

void main() {
  testWidgets('kirilmagan: kirish ekrani va 3 ta usul', (tester) async {
    await tester.pumpWidget(_app(null));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.loginTitle), findsOneWidget);
    expect(find.text(AppStrings.loginWithGoogle), findsOneWidget);
    expect(find.text(AppStrings.loginWithPhone), findsOneWidget);
    expect(find.text(AppStrings.loginWithTelegram), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('kirgan: pastki menyuda 4 bo\'lim, almashtirish ishlaydi', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const AppUser(uid: 'u1')));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationDestination), findsNWidgets(4));
    for (final label in [
      AppStrings.navHome,
      AppStrings.navEvents,
      AppStrings.navCalendar,
      AppStrings.navSettings,
    ]) {
      expect(find.text(label), findsOneWidget);
    }
    expect(find.text(AppStrings.homeEmptyTitle), findsOneWidget);

    await tester.tap(find.text(AppStrings.navCalendar));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.calendarEmptyTitle), findsOneWidget);

    await tester.tap(find.text(AppStrings.navSettings));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.settingsEmptyTitle), findsOneWidget);
  });

  testWidgets('"Qo\'shish" tugmasi to\'liq ekranli sahifani ochadi', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const AppUser(uid: 'u1')));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.addEvent));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.addEventTitle), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
