import 'package:eslat/app.dart';
import 'package:eslat/core/firebase/firebase_providers.dart';
import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers.dart';

void main() {
  // Profil yo'q bo'lsa ilova o'zbekcha ochiladi (telefon tili en_US bo'lsa ham).
  final uz = l10nFor('uz');

  testWidgets('kirilmagan: faqat Gmail tugmasi', (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    expect(find.text(uz.loginTitle), findsOneWidget);
    expect(find.text(uz.loginWithGoogle), findsOneWidget);
    expect(find.text(uz.loginAutoNote), findsOneWidget);
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
      uz.navHome,
      uz.navEvents,
      uz.navCalendar,
      uz.navSettings,
    ]) {
      expect(find.text(label), findsOneWidget);
    }
    expect(find.text(uz.homeEmptyTitle), findsOneWidget);

    await tester.tap(find.text(uz.navCalendar));
    await tester.pumpAndSettle();
    expect(find.text(uz.calendarNoEventsDay), findsOneWidget);
  });

  testWidgets('"Qo\'shish" to\'liq ekranli sahifani ochadi', (tester) async {
    await tester.pumpWidget(testApp(user: testUser));
    await tester.pumpAndSettle();

    await tester.tap(find.text(uz.addEvent));
    await tester.pumpAndSettle();

    expect(find.text(uz.addEventTitle), findsOneWidget);
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

    await tester.tap(find.text(uz.loginWithGoogle));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text(uz.demoBanner), findsOneWidget);
  });

  testWidgets('kirish ekranida bayroqli tillar, tanlansa darhol o\'zgaradi', (
    tester,
  ) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    expect(find.text('🇺🇿'), findsOneWidget);
    expect(find.text('🇷🇺'), findsOneWidget);
    expect(find.text('🇬🇧'), findsOneWidget);
    expect(find.text(uz.loginWithGoogle), findsOneWidget);

    await tester.tap(find.text('Русский'));
    await tester.pumpAndSettle();
    expect(find.text(l10nFor('ru').loginWithGoogle), findsOneWidget);
  });
}
