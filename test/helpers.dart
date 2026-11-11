import 'package:eslat/app.dart';
import 'package:eslat/core/firebase/firebase_providers.dart';
import 'package:eslat/core/platform/native_bridge.dart';
import 'package:eslat/features/auth/data/auth_repository.dart';
import 'package:eslat/features/auth/domain/app_user.dart';
import 'package:eslat/features/events/data/categories_repository.dart';
import 'package:eslat/features/events/data/events_repository.dart';
import 'package:eslat/features/events/domain/event_category.dart';
import 'package:eslat/features/events/domain/important_event.dart';
import 'package:eslat/features/events/presentation/events_providers.dart';
import 'package:eslat/features/profile/data/profile_repository.dart';
import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:eslat/l10n/gen/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const testUser = AppUser(uid: 'u1', displayName: 'Ali', email: 'ali@gmail.com');

/// Testlarda "bugun" doim shu sana (natijalar sanaga bog'liq bo'lmasin).
final testToday = DateTime(2026, 3, 10);

ImportantEvent testEvent({
  String title = "Onamning tug'ilgan kuni",
  EventCategory category = EventCategory.parentBirthday,
  int day = 10,
  int month = 3,
  int? year = 1966,
  bool repeatYearly = true,
}) => ImportantEvent(
  title: title,
  category: category,
  emoji: category.defaultEmoji,
  day: day,
  month: month,
  year: year,
  repeatYearly: repeatYearly,
);

/// Firebase'siz ilova: xotiradagi repository'lar, belgilangan sana.
Widget testApp({
  AppUser? user,
  UserProfile? profile,
  List<ImportantEvent> events = const [],
  InMemoryEventsRepository? eventsRepo,
  NativeBridge? bridge,
}) {
  final repo = eventsRepo ?? InMemoryEventsRepository();
  if (user != null) {
    for (final event in events) {
      repo.create(user.uid, event);
    }
  }
  return ProviderScope(
    overrides: [
      firebaseReadyProvider.overrideWithValue(true),
      authStateProvider.overrideWith((ref) => Stream.value(user)),
      currentProfileProvider.overrideWith((ref) => Stream.value(profile)),
      profileRepositoryProvider.overrideWithValue(InMemoryProfileRepository()),
      eventsRepositoryProvider.overrideWithValue(repo),
      categoriesRepositoryProvider.overrideWithValue(
        InMemoryCategoriesRepository(),
      ),
      todayProvider.overrideWithValue(testToday),
      if (bridge != null) nativeBridgeProvider.overrideWithValue(bridge),
    ],
    child: const EslatApp(),
  );
}

/// Telefon o'lchami (360×800 dp) — testlar haqiqiy ekranga yaqin bo'lsin.
void usePhoneScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

AppLocalizations l10nFor(String code) => lookupAppLocalizations(Locale(code));
