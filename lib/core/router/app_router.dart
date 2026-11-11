import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/alarm/presentation/alarm_screen.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/domain/app_user.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/calendar/presentation/calendar_screen.dart';
import '../../features/events/presentation/details/event_details_screen.dart';
import '../../features/events/presentation/events_screen.dart';
import '../../features/events/presentation/form/event_form_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../shared/widgets/coming_soon_screen.dart';
import '../l10n/l10n.dart';
import 'app_routes.dart';
import 'auth_redirect.dart';
import 'main_shell.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Ilovaning yagona routeri.
///
/// - Kirish holati o'zgarsa (`authStateProvider`) router avtomatik qayta
///   tekshiradi va kerakli ekranga yo'naltiradi.
/// - Pastki menyu `StatefulShellRoute` — har bir bo'lim o'z holatini
///   (scroll, ichki sahifalar) saqlab qoladi.
/// - "Coming soon" ekranlari keyingi qadamlarda haqiqiysiga almashtiriladi.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final authState = ValueNotifier<AsyncValue<AppUser?>>(const AsyncLoading());
  ref.listen(
    authStateProvider,
    (_, next) => authState.value = next,
    fireImmediately: true,
  );

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: authState,
    redirect: (_, state) => authRedirect(auth: authState.value, uri: state.uri),
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      // Hozircha bitta usul — Gmail. Telefon va Telegram keyinroq
      // `/auth/phone`, `/auth/telegram` sifatida qo'shiladi.
      GoRoute(path: AppRoutes.auth, builder: (_, _) => const LoginScreen()),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => MainShell(navigationShell: shell),
        branches: [
          _branch(AppRoutes.home, const HomeScreen()),
          _branch(AppRoutes.events, const EventsScreen()),
          _branch(AppRoutes.calendar, const CalendarScreen()),
          _branch(AppRoutes.settings, const SettingsScreen()),
        ],
      ),
      // To'liq ekranli sahifalar (pastki menyu ustida ochiladi).
      // DIQQAT: '/event/new' ':id' dan OLDIN turishi shart.
      GoRoute(
        path: AppRoutes.eventNew,
        builder: (_, _) => const EventFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.eventDetailsPattern,
        builder: (_, state) => EventDetailsScreen(
          eventId: state.pathParameters[AppRoutes.idParam]!,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.eventEditSegment,
            builder: (_, state) => EventFormScreen(
              eventId: state.pathParameters[AppRoutes.idParam],
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.alarmPattern,
        builder: (_, state) =>
            AlarmScreen(eventId: state.pathParameters[AppRoutes.idParam]!),
      ),
      GoRoute(
        path: AppRoutes.pro,
        builder: (context, _) => ComingSoonScreen(title: context.l10n.proTitle),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    authState.dispose();
  });
  return router;
}

StatefulShellBranch _branch(String path, Widget screen) {
  return StatefulShellBranch(
    routes: [GoRoute(path: path, builder: (_, _) => screen)],
  );
}
