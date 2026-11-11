import 'package:eslat/app.dart';
import 'package:eslat/core/firebase/firebase_providers.dart';
import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers.dart';

void main() {
  // Test muhitida telefon tili — en_US.
  final en = l10nFor('en');

  testWidgets('kirilmagan: faqat Gmail tugmasi', (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    expect(find.text(en.loginTitle), findsOneWidget);
    expect(find.text(en.loginWithGoogle), findsOneWidget);
    expect(find.text(en.loginAutoNote), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('kirgan: pastki menyuda 4 bo\'lim, almashtirish ishlaydi', (
    tester,
  ) async {
    usePhoneScreen(tester);
    await tester.pumpWidget(testApp(user: testUser));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationDestination), findsNWidgets(4));
    for (final label in [
      en.navHome,
      en.navEvents,
      en.navCalendar,
      en.navSettings,
    ]) {
      expect(find.text(label), findsOneWidget);
    }
    expect(find.text(en.homeEmptyTitle), findsOneWidget);

    await tester.tap(find.text(en.navCalendar));
    await tester.pumpAndSettle();
    expect(find.text(en.calendarNoEventsDay), findsOneWidget);
  });

  testWidgets('"Qo\'shish" to\'liq ekranli sahifani ochadi', (tester) async {
    await tester.pumpWidget(testApp(user: testUser));
    await tester.pumpAndSettle();

    await tester.tap(find.text(en.addEvent));
    await tester.pumpAndSettle();

    expect(find.text(en.addEventTitle), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  group('3 til', () {
    for (final code in ['uz', 'ru', 'en']) {
      testWidgets('profil tili "$code" — butun ilova shu tilda', (
        tester,
      ) async {
        final l10n = l10nFor(code);
        await tester.pumpWidget(
          testApp(
            user: testUser,
            profile: UserProfile(locale: code),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(l10n.navHome), findsOneWidget);
        expect(find.text(l10n.navSettings), findsOneWidget);
        expect(find.text(l10n.homeEmptyTitle), findsOneWidget);
      });
    }

    test('har bir tarjima o\'zbekcha shablondan farq qiladi', () {
      final uz = l10nFor('uz');
      expect(l10nFor('ru').loginTitle, isNot(uz.loginTitle));
      expect(l10nFor('en').loginTitle, isNot(uz.loginTitle));
    });
  });

  testWidgets('Firebase sozlanmagan: sinov rejimida kiradi va ogohlantiradi', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [firebaseReadyProvider.overrideWithValue(false)],
        child: const EslatApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(en.loginWithGoogle));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text(en.demoBanner), findsOneWidget);
  });
}
