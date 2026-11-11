import 'package:eslat/core/l10n/app_language.dart';
import 'package:eslat/core/theme/theme_settings.dart';
import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers.dart';

void main() {
  Future<void> openSettings(WidgetTester tester, UserProfile profile) async {
    await tester.pumpWidget(testApp(user: testUser, profile: profile));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10nFor(profile.locale).navSettings));
    await tester.pumpAndSettle();
  }

  testWidgets('hisob, 3 til, ko\'rinish, ranglar va chiqish ko\'rinadi', (
    tester,
  ) async {
    final uz = l10nFor('uz');
    await openSettings(tester, const UserProfile(locale: 'uz'));

    expect(find.text('Ali'), findsOneWidget);
    expect(find.text('ali@gmail.com'), findsOneWidget);
    expect(find.text(uz.settingsPlanFree), findsOneWidget);
    for (final language in AppLanguage.values) {
      expect(find.text(language.nativeName), findsOneWidget);
    }
    expect(find.text(uz.themeModeDark), findsOneWidget);

    await tester.scrollUntilVisible(find.text(uz.signOut), 200);
    expect(find.text(uz.signOut), findsOneWidget);
  });

  testWidgets('saqlangan tungi rejim va rang qo\'llanadi', (tester) async {
    const teal = 0xFF00897B;
    await openSettings(
      tester,
      const UserProfile(
        locale: 'ru',
        settings: ThemeSettings(
          themeMode: ThemeMode.dark,
          seedColorValue: teal,
        ),
      ),
    );

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
    final expected = ColorScheme.fromSeed(
      seedColor: const Color(teal),
      brightness: Brightness.dark,
    ).primary;
    expect(app.darkTheme!.colorScheme.primary, expected);
  });

  testWidgets(
    'chiqishda tasdiq so\'raladi, "Bekor qilish" — hech narsa qilmaydi',
    (tester) async {
      final en = l10nFor('en');
      await openSettings(tester, const UserProfile(locale: 'en'));

      await tester.scrollUntilVisible(find.text(en.signOut), 200);
      await tester.tap(find.text(en.signOut));
      await tester.pumpAndSettle();
      expect(find.text(en.signOutConfirmTitle), findsOneWidget);

      await tester.tap(find.text(en.cancel));
      await tester.pumpAndSettle();
      expect(find.text(en.signOutConfirmTitle), findsNothing);
      expect(find.widgetWithText(AppBar, en.settingsTitle), findsOneWidget);
    },
  );
}
