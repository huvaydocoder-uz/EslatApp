// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kirish va chiqish amallari. Holat: yuklanmoqda / xato (AuthFailure) / tayyor.
///
/// `keepAlive` — kirish muvaffaqiyatli bo'lgach router darhol `/home` ga
/// o'tadi va kirish ekrani yopiladi; profil yaratish esa shu yerda tugaydi.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// Kirish va chiqish amallari. Holat: yuklanmoqda / xato (AuthFailure) / tayyor.
///
/// `keepAlive` — kirish muvaffaqiyatli bo'lgach router darhol `/home` ga
/// o'tadi va kirish ekrani yopiladi; profil yaratish esa shu yerda tugaydi.
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, void> {
  /// Kirish va chiqish amallari. Holat: yuklanmoqda / xato (AuthFailure) / tayyor.
  ///
  /// `keepAlive` — kirish muvaffaqiyatli bo'lgach router darhol `/home` ga
  /// o'tadi va kirish ekrani yopiladi; profil yaratish esa shu yerda tugaydi.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'cb6273b54094d0d6f7d380692daf0f42bd990848';

/// Kirish va chiqish amallari. Holat: yuklanmoqda / xato (AuthFailure) / tayyor.
///
/// `keepAlive` — kirish muvaffaqiyatli bo'lgach router darhol `/home` ga
/// o'tadi va kirish ekrani yopiladi; profil yaratish esa shu yerda tugaydi.

abstract class _$AuthController extends $AsyncNotifier<void> {
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
