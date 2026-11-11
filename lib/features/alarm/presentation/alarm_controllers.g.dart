// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Budilnik musiqasi (telefon xotirasidan). `null` — standart budilnik ovozi.
/// Faqat shu telefonda saqlanadi: fayl boshqa telefonda bo'lmaydi.

@ProviderFor(AlarmSoundController)
final alarmSoundControllerProvider = AlarmSoundControllerProvider._();

/// Budilnik musiqasi (telefon xotirasidan). `null` — standart budilnik ovozi.
/// Faqat shu telefonda saqlanadi: fayl boshqa telefonda bo'lmaydi.
final class AlarmSoundControllerProvider
    extends $AsyncNotifierProvider<AlarmSoundController, String?> {
  /// Budilnik musiqasi (telefon xotirasidan). `null` — standart budilnik ovozi.
  /// Faqat shu telefonda saqlanadi: fayl boshqa telefonda bo'lmaydi.
  AlarmSoundControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmSoundControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmSoundControllerHash();

  @$internal
  @override
  AlarmSoundController create() => AlarmSoundController();
}

String _$alarmSoundControllerHash() =>
    r'33308c1e912e05c35419d45d0f4fafa472f9fbac';

/// Budilnik musiqasi (telefon xotirasidan). `null` — standart budilnik ovozi.
/// Faqat shu telefonda saqlanadi: fayl boshqa telefonda bo'lmaydi.

abstract class _$AlarmSoundController extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// "Tinglab ko'rish": 10 soniya chaladi yoki qo'lda to'xtatiladi.

@ProviderFor(AlarmPreview)
final alarmPreviewProvider = AlarmPreviewProvider._();

/// "Tinglab ko'rish": 10 soniya chaladi yoki qo'lda to'xtatiladi.
final class AlarmPreviewProvider extends $NotifierProvider<AlarmPreview, bool> {
  /// "Tinglab ko'rish": 10 soniya chaladi yoki qo'lda to'xtatiladi.
  AlarmPreviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmPreviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmPreviewHash();

  @$internal
  @override
  AlarmPreview create() => AlarmPreview();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$alarmPreviewHash() => r'4890a72e21ff4c7f3aa2f7b693113f2277b704e7';

/// "Tinglab ko'rish": 10 soniya chaladi yoki qo'lda to'xtatiladi.

abstract class _$AlarmPreview extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Chalayotgan budilnikni to'xtatish (budilnik ekranidan).

@ProviderFor(AlarmController)
final alarmControllerProvider = AlarmControllerProvider._();

/// Chalayotgan budilnikni to'xtatish (budilnik ekranidan).
final class AlarmControllerProvider
    extends $AsyncNotifierProvider<AlarmController, void> {
  /// Chalayotgan budilnikni to'xtatish (budilnik ekranidan).
  AlarmControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmControllerHash();

  @$internal
  @override
  AlarmController create() => AlarmController();
}

String _$alarmControllerHash() => r'17b22d72a3a80ac2c47d1bc1efb408bc8b3e18bd';

/// Chalayotgan budilnikni to'xtatish (budilnik ekranidan).

abstract class _$AlarmController extends $AsyncNotifier<void> {
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
