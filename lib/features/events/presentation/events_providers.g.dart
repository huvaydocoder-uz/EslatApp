// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Bugungi sana (soatsiz). Testlarda almashtiriladi.

@ProviderFor(today)
final todayProvider = TodayProvider._();

/// Bugungi sana (soatsiz). Testlarda almashtiriladi.

final class TodayProvider
    extends $FunctionalProvider<DateTime, DateTime, DateTime>
    with $Provider<DateTime> {
  /// Bugungi sana (soatsiz). Testlarda almashtiriladi.
  TodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayHash();

  @$internal
  @override
  $ProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DateTime create(Ref ref) {
    return today(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$todayHash() => r'd5d05d4a70d4a0614a22e21e271c69e4f9851721';

/// Barcha muhim kunlar keyingi sanasi bo'yicha saralangan holda.

@ProviderFor(eventOccurrences)
final eventOccurrencesProvider = EventOccurrencesProvider._();

/// Barcha muhim kunlar keyingi sanasi bo'yicha saralangan holda.

final class EventOccurrencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EventOccurrence>>,
          AsyncValue<List<EventOccurrence>>,
          AsyncValue<List<EventOccurrence>>
        >
    with $Provider<AsyncValue<List<EventOccurrence>>> {
  /// Barcha muhim kunlar keyingi sanasi bo'yicha saralangan holda.
  EventOccurrencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventOccurrencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventOccurrencesHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<EventOccurrence>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<EventOccurrence>> create(Ref ref) {
    return eventOccurrences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<EventOccurrence>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<EventOccurrence>>>(
        value,
      ),
    );
  }
}

String _$eventOccurrencesHash() => r'e53a3cfe4631869a984c5b79694c1e90a3c03ec7';

/// "Kunlar" ekranidagi toifa filtri. `null` — hammasi.

@ProviderFor(EventsFilter)
final eventsFilterProvider = EventsFilterProvider._();

/// "Kunlar" ekranidagi toifa filtri. `null` — hammasi.
final class EventsFilterProvider
    extends $NotifierProvider<EventsFilter, EventCategory?> {
  /// "Kunlar" ekranidagi toifa filtri. `null` — hammasi.
  EventsFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsFilterHash();

  @$internal
  @override
  EventsFilter create() => EventsFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventCategory? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventCategory?>(value),
    );
  }
}

String _$eventsFilterHash() => r'263ca117b252b1f97f98ee16e82b7943ea94c9e8';

/// "Kunlar" ekranidagi toifa filtri. `null` — hammasi.

abstract class _$EventsFilter extends $Notifier<EventCategory?> {
  EventCategory? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EventCategory?, EventCategory?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EventCategory?, EventCategory?>,
              EventCategory?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Bitta muhim kun (tafsilotlar ekrani uchun). Topilmasa — `null`.

@ProviderFor(eventOccurrence)
final eventOccurrenceProvider = EventOccurrenceFamily._();

/// Bitta muhim kun (tafsilotlar ekrani uchun). Topilmasa — `null`.

final class EventOccurrenceProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventOccurrence?>,
          AsyncValue<EventOccurrence?>,
          AsyncValue<EventOccurrence?>
        >
    with $Provider<AsyncValue<EventOccurrence?>> {
  /// Bitta muhim kun (tafsilotlar ekrani uchun). Topilmasa — `null`.
  EventOccurrenceProvider._({
    required EventOccurrenceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventOccurrenceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventOccurrenceHash();

  @override
  String toString() {
    return r'eventOccurrenceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<EventOccurrence?>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<EventOccurrence?> create(Ref ref) {
    final argument = this.argument as String;
    return eventOccurrence(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<EventOccurrence?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<EventOccurrence?>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EventOccurrenceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventOccurrenceHash() => r'1247850de685e39428447ae7b14f4d4be89dc872';

/// Bitta muhim kun (tafsilotlar ekrani uchun). Topilmasa — `null`.

final class EventOccurrenceFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<EventOccurrence?>, String> {
  EventOccurrenceFamily._()
    : super(
        retry: null,
        name: r'eventOccurrenceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bitta muhim kun (tafsilotlar ekrani uchun). Topilmasa — `null`.

  EventOccurrenceProvider call(String eventId) =>
      EventOccurrenceProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventOccurrenceProvider';
}
