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

/// Kirishdan oldin (kirish ekranida) tanlangan til. Kirgach profilga yoziladi.

@ProviderFor(LanguageChoice)
final languageChoiceProvider = LanguageChoiceProvider._();

/// Kirishdan oldin (kirish ekranida) tanlangan til. Kirgach profilga yoziladi.
final class LanguageChoiceProvider
    extends $NotifierProvider<LanguageChoice, AppLanguage?> {
  /// Kirishdan oldin (kirish ekranida) tanlangan til. Kirgach profilga yoziladi.
  LanguageChoiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageChoiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageChoiceHash();

  @$internal
  @override
  LanguageChoice create() => LanguageChoice();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLanguage? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLanguage?>(value),
    );
  }
}

String _$languageChoiceHash() => r'dfb7e5fe0412ce42d6f0ef3b833a557b7c9740aa';

/// Kirishdan oldin (kirish ekranida) tanlangan til. Kirgach profilga yoziladi.

abstract class _$LanguageChoice extends $Notifier<AppLanguage?> {
  AppLanguage? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppLanguage?, AppLanguage?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLanguage?, AppLanguage?>,
              AppLanguage?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Ekrandagi til: profildagi → kirishdan oldin tanlangan → o'zbekcha.

@ProviderFor(appLanguage)
final appLanguageProvider = AppLanguageProvider._();

/// Ekrandagi til: profildagi → kirishdan oldin tanlangan → o'zbekcha.

final class AppLanguageProvider
    extends $FunctionalProvider<AppLanguage, AppLanguage, AppLanguage>
    with $Provider<AppLanguage> {
  /// Ekrandagi til: profildagi → kirishdan oldin tanlangan → o'zbekcha.
  AppLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLanguageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLanguageHash();

  @$internal
  @override
  $ProviderElement<AppLanguage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLanguage create(Ref ref) {
    return appLanguage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLanguage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLanguage>(value),
    );
  }
}

String _$appLanguageHash() => r'1a00aa1a682288a8ec200eae0b5e6b5962c5e896';

@ProviderFor(appLocale)
final appLocaleProvider = AppLocaleProvider._();

final class AppLocaleProvider
    extends $FunctionalProvider<Locale, Locale, Locale>
    with $Provider<Locale> {
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
  $ProviderElement<Locale> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Locale create(Ref ref) {
    return appLocale(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$appLocaleHash() => r'a882de3f6bd32b96c8e9f3f1920a2e187d78228b';
