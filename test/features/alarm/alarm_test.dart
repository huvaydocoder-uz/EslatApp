import 'package:eslat/core/platform/native_bridge.dart';
import 'package:eslat/core/router/app_router.dart';
import 'package:eslat/core/router/app_routes.dart';
import 'package:eslat/features/events/data/events_repository.dart';
import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers.dart';

class AlarmBridge extends NoopNativeBridge {
  String? sound;
  var stops = 0;

  @override
  Future<String?> alarmSoundName() async => sound;

  @override
  Future<String?> pickAlarmSound() async => sound = 'Onajonim';

  @override
  Future<void> resetAlarmSound() async => sound = null;

  @override
  Future<void> stopAlarm() async => stops++;
}

void main() {
  final en = l10nFor('en');
  const profile = UserProfile(locale: 'en');

  testWidgets(
    'budilnik sahifasi: kun ko\'rinadi, "To\'xtatish" budilnikni to\'xtatadi',
    (tester) async {
      usePhoneScreen(tester);
      final bridge = AlarmBridge();
      final repo = InMemoryEventsRepository();
      final id = await repo.create(testUser.uid, testEvent(title: 'Mom'));
      await tester.pumpWidget(
        testApp(
          user: testUser,
          profile: profile,
          eventsRepo: repo,
          bridge: bridge,
        ),
      );
      await tester.pumpAndSettle();

      final container = ProviderScope.containerOf(
        tester.element(find.byType(MaterialApp)),
      );
      container.read(appRouterProvider).go(AppRoutes.alarm(id));
      await tester.pumpAndSettle();

      expect(find.text('Mom'), findsOneWidget);
      expect(find.text(en.alarmTitle), findsOneWidget);

      await tester.tap(find.text(en.alarmStop));
      await tester.pumpAndSettle();
      expect(bridge.stops, 1);
      expect(find.text(en.eventDetailsTitle), findsOneWidget);
    },
  );

  testWidgets(
    'Sozlamalar: musiqa tanlash, nomi ko\'rinadi, standartga qaytarish',
    (tester) async {
      usePhoneScreen(tester);
      final bridge = AlarmBridge();
      await tester.pumpWidget(
        testApp(user: testUser, profile: profile, bridge: bridge),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(en.navSettings));
      await tester.pumpAndSettle();

      // Pastki menyudagi boshqa bo'limlarning ham Scrollable'i bor — aynan
      // Sozlamalar ro'yxatini olamiz.
      final list = find
          .ancestor(
            of: find.text(en.settingsLanguage),
            matching: find.byType(Scrollable),
          )
          .first;
      await tester.scrollUntilVisible(
        find.text(en.alarmSoundPick),
        200,
        scrollable: list,
      );
      expect(find.text(en.alarmSoundDefault), findsOneWidget);

      await tester.ensureVisible(find.text(en.alarmSoundPick));
      await tester.pumpAndSettle();
      await tester.tap(find.text(en.alarmSoundPick));
      await tester.pumpAndSettle();
      expect(find.text('Onajonim'), findsOneWidget);

      await tester.ensureVisible(find.text(en.alarmSoundReset));
      await tester.pumpAndSettle();
      await tester.tap(find.text(en.alarmSoundReset));
      await tester.pumpAndSettle();
      expect(find.text('Onajonim'), findsNothing);
      expect(bridge.sound, isNull);
    },
  );
}
