// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventsRepository)
final eventsRepositoryProvider = EventsRepositoryProvider._();

final class EventsRepositoryProvider
    extends
        $FunctionalProvider<
          EventsRepository,
          EventsRepository,
          EventsRepository
        >
    with $Provider<EventsRepository> {
  EventsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventsRepository create(Ref ref) {
    return eventsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventsRepository>(value),
    );
  }
}

String _$eventsRepositoryHash() => r'7f905dd9d7b303953069ae3bb94700d5582daa53';

/// Kirgan foydalanuvchining barcha muhim kunlari (real vaqtda).

@ProviderFor(events)
final eventsProvider = EventsProvider._();

/// Kirgan foydalanuvchining barcha muhim kunlari (real vaqtda).

final class EventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ImportantEvent>>,
          List<ImportantEvent>,
          Stream<List<ImportantEvent>>
        >
    with
        $FutureModifier<List<ImportantEvent>>,
        $StreamProvider<List<ImportantEvent>> {
  /// Kirgan foydalanuvchining barcha muhim kunlari (real vaqtda).
  EventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsHash();

  @$internal
  @override
  $StreamProviderElement<List<ImportantEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ImportantEvent>> create(Ref ref) {
    return events(ref);
  }
}

String _$eventsHash() => r'a30d1b36714ce22a70e8243191eed8e5583c6c31';
