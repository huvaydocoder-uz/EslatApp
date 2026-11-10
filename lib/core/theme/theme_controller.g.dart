// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mavzu holati (kunduzgi/tungi rejim va asosiy rang).
///
/// Butun ilova shu providerni kuzatadi — rang o'zgarishi bilan barcha
/// ekranlar darhol qayta chiziladi. 2-qadamda tanlov Firestore'dagi
/// `users/{uid}.settings` ga saqlanadi va qurilmalar o'rtasida sinxronlanadi.

@ProviderFor(ThemeController)
final themeControllerProvider = ThemeControllerProvider._();

/// Mavzu holati (kunduzgi/tungi rejim va asosiy rang).
///
/// Butun ilova shu providerni kuzatadi — rang o'zgarishi bilan barcha
/// ekranlar darhol qayta chiziladi. 2-qadamda tanlov Firestore'dagi
/// `users/{uid}.settings` ga saqlanadi va qurilmalar o'rtasida sinxronlanadi.
final class ThemeControllerProvider
    extends $NotifierProvider<ThemeController, ThemeSettings> {
  /// Mavzu holati (kunduzgi/tungi rejim va asosiy rang).
  ///
  /// Butun ilova shu providerni kuzatadi — rang o'zgarishi bilan barcha
  /// ekranlar darhol qayta chiziladi. 2-qadamda tanlov Firestore'dagi
  /// `users/{uid}.settings` ga saqlanadi va qurilmalar o'rtasida sinxronlanadi.
  ThemeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeControllerHash();

  @$internal
  @override
  ThemeController create() => ThemeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeSettings>(value),
    );
  }
}

String _$themeControllerHash() => r'6c7633a1a9f0d943dfed153a29a1c799a69aa0cb';

/// Mavzu holati (kunduzgi/tungi rejim va asosiy rang).
///
/// Butun ilova shu providerni kuzatadi — rang o'zgarishi bilan barcha
/// ekranlar darhol qayta chiziladi. 2-qadamda tanlov Firestore'dagi
/// `users/{uid}.settings` ga saqlanadi va qurilmalar o'rtasida sinxronlanadi.

abstract class _$ThemeController extends $Notifier<ThemeSettings> {
  ThemeSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeSettings, ThemeSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeSettings, ThemeSettings>,
              ThemeSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
