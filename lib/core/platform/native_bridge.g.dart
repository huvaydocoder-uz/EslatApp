// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_bridge.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nativeBridge)
final nativeBridgeProvider = NativeBridgeProvider._();

final class NativeBridgeProvider
    extends $FunctionalProvider<NativeBridge, NativeBridge, NativeBridge>
    with $Provider<NativeBridge> {
  NativeBridgeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nativeBridgeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nativeBridgeHash();

  @$internal
  @override
  $ProviderElement<NativeBridge> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NativeBridge create(Ref ref) {
    return nativeBridge(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NativeBridge value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NativeBridge>(value),
    );
  }
}

String _$nativeBridgeHash() => r'b6e09ee2824e20dd7dea30dab554134fcb7e548c';
