// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'770d470b6f0e8816f6f8fa1d3abf7d2b386b222a';

/// Kirgan foydalanuvchining profili (real vaqtda). Kirilmagan — `null`.
///
/// Firestore o'zgarishni avval qurilmada qo'llaydi, shuning uchun til yoki
/// rang tanlansa ekran internetni kutmasdan darhol yangilanadi.

@ProviderFor(currentProfile)
final currentProfileProvider = CurrentProfileProvider._();

/// Kirgan foydalanuvchining profili (real vaqtda). Kirilmagan — `null`.
///
/// Firestore o'zgarishni avval qurilmada qo'llaydi, shuning uchun til yoki
/// rang tanlansa ekran internetni kutmasdan darhol yangilanadi.

final class CurrentProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserProfile?>,
          UserProfile?,
          Stream<UserProfile?>
        >
    with $FutureModifier<UserProfile?>, $StreamProvider<UserProfile?> {
  /// Kirgan foydalanuvchining profili (real vaqtda). Kirilmagan — `null`.
  ///
  /// Firestore o'zgarishni avval qurilmada qo'llaydi, shuning uchun til yoki
  /// rang tanlansa ekran internetni kutmasdan darhol yangilanadi.
  CurrentProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentProfileHash();

  @$internal
  @override
  $StreamProviderElement<UserProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UserProfile?> create(Ref ref) {
    return currentProfile(ref);
  }
}

String _$currentProfileHash() => r'a65b54cd14c451ee921e240c82b6171f8be8bc9f';
