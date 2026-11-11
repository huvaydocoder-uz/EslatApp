// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Muhim kun ustidagi amallar (hozircha: o'chirish).

@ProviderFor(EventActions)
final eventActionsProvider = EventActionsProvider._();

/// Muhim kun ustidagi amallar (hozircha: o'chirish).
final class EventActionsProvider
    extends $AsyncNotifierProvider<EventActions, void> {
  /// Muhim kun ustidagi amallar (hozircha: o'chirish).
  EventActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventActionsHash();

  @$internal
  @override
  EventActions create() => EventActions();
}

String _$eventActionsHash() => r'f1b211537f05d8ec565d7b1e38442cf281617de7';

/// Muhim kun ustidagi amallar (hozircha: o'chirish).

abstract class _$EventActions extends $AsyncNotifier<void> {
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
