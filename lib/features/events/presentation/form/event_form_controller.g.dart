// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Qo'shish / tahrirlash formasi. `eventId == null` — yangi kun.

@ProviderFor(EventFormController)
final eventFormControllerProvider = EventFormControllerFamily._();

/// Qo'shish / tahrirlash formasi. `eventId == null` — yangi kun.
final class EventFormControllerProvider
    extends $NotifierProvider<EventFormController, EventFormState> {
  /// Qo'shish / tahrirlash formasi. `eventId == null` — yangi kun.
  EventFormControllerProvider._({
    required EventFormControllerFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'eventFormControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventFormControllerHash();

  @override
  String toString() {
    return r'eventFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventFormController create() => EventFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventFormState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EventFormControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventFormControllerHash() =>
    r'beb1d82833e473326e6b1da166e3d579da104a9a';

/// Qo'shish / tahrirlash formasi. `eventId == null` — yangi kun.

final class EventFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          EventFormController,
          EventFormState,
          EventFormState,
          EventFormState,
          String?
        > {
  EventFormControllerFamily._()
    : super(
        retry: null,
        name: r'eventFormControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Qo'shish / tahrirlash formasi. `eventId == null` — yangi kun.

  EventFormControllerProvider call(String? eventId) =>
      EventFormControllerProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventFormControllerProvider';
}

/// Qo'shish / tahrirlash formasi. `eventId == null` — yangi kun.

abstract class _$EventFormController extends $Notifier<EventFormState> {
  late final _$args = ref.$arg as String?;
  String? get eventId => _$args;

  EventFormState build(String? eventId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EventFormState, EventFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EventFormState, EventFormState>,
              EventFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
