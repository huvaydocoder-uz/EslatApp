import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers.dart';

void main() {
  final en = l10nFor('en');

  testWidgets(
    'o\'z turi: forma ichida yaratiladi, tanlanadi, filtrda chiqadi',
    (tester) async {
      usePhoneScreen(tester);
      await tester.pumpWidget(
        testApp(
          user: testUser,
          profile: const UserProfile(locale: 'en'),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(en.addEvent));
      await tester.pumpAndSettle();
      await tester.tap(find.text(en.formNewType));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, en.newTypeName),
        'Work anniversary',
      );
      await tester.tap(find.text(en.createAction));
      await tester.pumpAndSettle();

      // Yangi tur tanlangan holda chiqdi.
      final chip = tester.widget<ChoiceChip>(
        find.widgetWithText(ChoiceChip, 'Work anniversary'),
      );
      expect(chip.selected, isTrue);

      await tester.enterText(
        find.widgetWithText(TextField, en.formTitle),
        'Company day',
      );
      await tester.tap(find.text(en.formSave));
      await tester.pumpAndSettle();

      await tester.tap(find.text(en.navEvents));
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.widgetWithText(ChoiceChip, 'Work anniversary'),
      );
      await tester.tap(find.widgetWithText(ChoiceChip, 'Work anniversary'));
      await tester.pumpAndSettle();
      expect(find.text('Company day'), findsOneWidget);
    },
  );

  testWidgets('eslatish vaqti formada ko\'rinadi (standart 09:00)', (
    tester,
  ) async {
    usePhoneScreen(tester);
    await tester.pumpWidget(
      testApp(
        user: testUser,
        profile: const UserProfile(locale: 'en'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(en.addEvent));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text(en.formNotifyTime),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text(en.formNotifyTime), findsOneWidget);
    expect(find.text('09:00'), findsOneWidget);
  });
}
