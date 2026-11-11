// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Butun ilova mavzusi — foydalanuvchi profilidan (`users/{uid}.settings`).
/// Kirilmagan yoki profil hali yuklanmagan bo'lsa — standart mavzu.

@ProviderFor(themeSettings)
final themeSettingsProvider = ThemeSettingsProvider._();

/// Butun ilova mavzusi — foydalanuvchi profilidan (`users/{uid}.settings`).
/// Kirilmagan yoki profil hali yuklanmagan bo'lsa — standart mavzu.

final class ThemeSettingsProvider
    extends $FunctionalProvider<ThemeSettings, ThemeSettings, ThemeSettings>
    with $Provider<ThemeSettings> {
  /// Butun ilova mavzusi — foydalanuvchi profilidan (`users/{uid}.settings`).
  /// Kirilmagan yoki profil hali yuklanmagan bo'lsa — standart mavzu.
  ThemeSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeSettingsHash();

  @$internal
  @override
  $ProviderElement<ThemeSettings> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeSettings create(Ref ref) {
    return themeSettings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeSettings>(value),
    );
  }
}

String _$themeSettingsHash() => r'7e544b619f7a5367ea9ffced6ce3e956fed6733a';

/// Foydalanuvchi tanlagan til. `null` — telefon tili bo'yicha avtomatik.

@ProviderFor(appLocale)
final appLocaleProvider = AppLocaleProvider._();

/// Foydalanuvchi tanlagan til. `null` — telefon tili bo'yicha avtomatik.

final class AppLocaleProvider
    extends $FunctionalProvider<Locale?, Locale?, Locale?>
    with $Provider<Locale?> {
  /// Foydalanuvchi tanlagan til. `null` — telefon tili bo'yicha avtomatik.
  AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  $ProviderElement<Locale?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Locale? create(Ref ref) {
    return appLocale(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale?>(value),
    );
  }
}

String _$appLocaleHash() => r'9479ce65bcd28fe95ee80893c79ec1299cfdfc47';
