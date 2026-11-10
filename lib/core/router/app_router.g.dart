// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ilovaning yagona routeri.
///
/// - Kirish holati o'zgarsa (`authStateProvider`) router avtomatik qayta
///   tekshiradi va kerakli ekranga yo'naltiradi.
/// - Pastki menyu `StatefulShellRoute` — har bir bo'lim o'z holatini
///   (scroll, ichki sahifalar) saqlab qoladi.
/// - "Coming soon" ekranlari keyingi qadamlarda haqiqiysiga almashtiriladi.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// Ilovaning yagona routeri.
///
/// - Kirish holati o'zgarsa (`authStateProvider`) router avtomatik qayta
///   tekshiradi va kerakli ekranga yo'naltiradi.
/// - Pastki menyu `StatefulShellRoute` — har bir bo'lim o'z holatini
///   (scroll, ichki sahifalar) saqlab qoladi.
/// - "Coming soon" ekranlari keyingi qadamlarda haqiqiysiga almashtiriladi.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Ilovaning yagona routeri.
  ///
  /// - Kirish holati o'zgarsa (`authStateProvider`) router avtomatik qayta
  ///   tekshiradi va kerakli ekranga yo'naltiradi.
  /// - Pastki menyu `StatefulShellRoute` — har bir bo'lim o'z holatini
  ///   (scroll, ichki sahifalar) saqlab qoladi.
  /// - "Coming soon" ekranlari keyingi qadamlarda haqiqiysiga almashtiriladi.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'f68a18625c58cd0892dd7d0f74ed909d0b9c232a';
