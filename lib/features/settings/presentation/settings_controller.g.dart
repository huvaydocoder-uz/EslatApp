// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Sozlamalarni saqlash: til, kunduzgi/tungi rejim, asosiy rang.
///
/// Firestore o'zgarishni avval qurilmada qo'llaydi — ekran darhol yangilanadi,
/// internet bo'lmasa ham. Xatolik (masalan, ruxsat yo'q) holatda `AsyncError`.

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

/// Sozlamalarni saqlash: til, kunduzgi/tungi rejim, asosiy rang.
///
/// Firestore o'zgarishni avval qurilmada qo'llaydi — ekran darhol yangilanadi,
/// internet bo'lmasa ham. Xatolik (masalan, ruxsat yo'q) holatda `AsyncError`.
final class SettingsControllerProvider
    extends $AsyncNotifierProvider<SettingsController, void> {
  /// Sozlamalarni saqlash: til, kunduzgi/tungi rejim, asosiy rang.
  ///
  /// Firestore o'zgarishni avval qurilmada qo'llaydi — ekran darhol yangilanadi,
  /// internet bo'lmasa ham. Xatolik (masalan, ruxsat yo'q) holatda `AsyncError`.
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();
}

String _$settingsControllerHash() =>
    r'50ae26b267976202c0b711857f788af522d6f9f5';

/// Sozlamalarni saqlash: til, kunduzgi/tungi rejim, asosiy rang.
///
/// Firestore o'zgarishni avval qurilmada qo'llaydi — ekran darhol yangilanadi,
/// internet bo'lmasa ham. Xatolik (masalan, ruxsat yo'q) holatda `AsyncError`.

abstract class _$SettingsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
