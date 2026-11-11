// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Taqvim: ko'rsatilayotgan oy va tanlangan kun.

@ProviderFor(CalendarController)
final calendarControllerProvider = CalendarControllerProvider._();

/// Taqvim: ko'rsatilayotgan oy va tanlangan kun.
final class CalendarControllerProvider
    extends $NotifierProvider<CalendarController, CalendarState> {
  /// Taqvim: ko'rsatilayotgan oy va tanlangan kun.
  CalendarControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarControllerHash();

  @$internal
  @override
  CalendarController create() => CalendarController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarState>(value),
    );
  }
}

String _$calendarControllerHash() =>
    r'96d2b501824783d625af99b5112db3631f029d54';

/// Taqvim: ko'rsatilayotgan oy va tanlangan kun.

abstract class _$CalendarController extends $Notifier<CalendarState> {
  CalendarState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CalendarState, CalendarState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalendarState, CalendarState>,
              CalendarState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
