import 'package:eslat/features/events/data/events_repository.dart';
import 'package:eslat/features/events/domain/event_category.dart';
import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers.dart';

void main() {
  final en = l10nFor('en');
  const profile = UserProfile(locale: 'en');

  testWidgets('qo\'shish: forma → saqlash → Asosiy va Kunlar\'da ko\'rinadi', (
    tester,
  ) async {
    usePhoneScreen(tester);
    await tester.pumpWidget(testApp(user: testUser, profile: profile));
    await tester.pumpAndSettle();
    expect(find.text(en.homeEmptyTitle), findsOneWidget);

    await tester.tap(find.text(en.addEvent));
    await tester.pumpAndSettle();
    await tester.tap(find.text(en.formSave));
    await tester.pumpAndSettle();
    expect(find.text(en.formErrorRequired), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, en.formTitle), 'Mom');
    await tester.tap(find.text(en.formSave));
    await tester.pumpAndSettle();

    // Forma yopildi; bugungi sana bilan qo'shildi — "Bugun!" bo'limida.
    expect(find.text(en.formSave), findsNothing);
    expect(find.text('Mom'), findsOneWidget);
    expect(find.text(en.today), findsOneWidget);

    await tester.tap(find.text(en.navEvents));
    await tester.pumpAndSettle();
    expect(find.text('Mom'), findsOneWidget);
  });

  testWidgets('tafsilotlar va o\'chirish (tasdiq bilan)', (tester) async {
    usePhoneScreen(tester);
    final repo = InMemoryEventsRepository();
    await tester.pumpWidget(
      testApp(
        user: testUser,
        profile: profile,
        events: [testEvent(title: 'Mom', day: 15)],
        eventsRepo: repo,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(en.daysLeft(5)), findsOneWidget);
    expect(find.text(en.turnsAge(60)), findsOneWidget);

    await tester.tap(find.text('Mom'));
    await tester.pumpAndSettle();
    expect(find.text(en.eventDetailsTitle), findsOneWidget);

    await tester.tap(find.byTooltip(en.deleteAction));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, en.deleteAction));
    await tester.pumpAndSettle();

    expect(find.text('Mom'), findsNothing);
    expect(find.text(en.homeEmptyTitle), findsOneWidget);
    final stored = await tester.runAsync(
      () => repo.watchAll(testUser.uid).first,
    );
    expect(stored, isEmpty);
  });

  testWidgets('yaqin 30 kundan keyingisi Asosiy\'da emas, Kunlar\'da bor', (
    tester,
  ) async {
    usePhoneScreen(tester);
    await tester.pumpWidget(
      testApp(
        user: testUser,
        profile: profile,
        events: [testEvent(title: 'Far', month: 8)],
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(en.homeNothingSoonTitle), findsOneWidget);

    await tester.tap(find.text(en.navEvents));
    await tester.pumpAndSettle();
    expect(find.text('Far'), findsOneWidget);
  });

  testWidgets('Kunlar: toifa filtri', (tester) async {
    usePhoneScreen(tester);
    await tester.pumpWidget(
      testApp(
        user: testUser,
        profile: profile,
        events: [
          testEvent(title: 'Mom'),
          testEvent(title: 'Wedding', category: EventCategory.anniversary),
        ],
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(en.navEvents));
    await tester.pumpAndSettle();
    expect(find.text('Wedding'), findsOneWidget);

    await tester.ensureVisible(find.text(en.categoryParentBirthday));
    await tester.tap(find.text(en.categoryParentBirthday));
    await tester.pumpAndSettle();
    expect(find.text('Mom'), findsOneWidget);
    expect(find.text('Wedding'), findsNothing);
  });

  testWidgets('Taqvim: kun emoji bilan, bosilsa o\'sha kungi ro\'yxat', (
    tester,
  ) async {
    usePhoneScreen(tester);
    await tester.pumpWidget(
      testApp(
        user: testUser,
        profile: profile,
        events: [testEvent(title: 'Mom', day: 20)],
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(en.navCalendar));
    await tester.pumpAndSettle();
    expect(find.text(en.calendarNoEventsDay), findsOneWidget);
    expect(find.text('👵'), findsOneWidget);

    await tester.tap(find.text('20'));
    await tester.pumpAndSettle();
    expect(find.text('Mom'), findsOneWidget);
  });
}
