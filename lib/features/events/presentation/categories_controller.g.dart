// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// O'z turlarini yaratish va o'chirish.

@ProviderFor(CategoriesController)
final categoriesControllerProvider = CategoriesControllerProvider._();

/// O'z turlarini yaratish va o'chirish.
final class CategoriesControllerProvider
    extends $AsyncNotifierProvider<CategoriesController, void> {
  /// O'z turlarini yaratish va o'chirish.
  CategoriesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesControllerHash();

  @$internal
  @override
  CategoriesController create() => CategoriesController();
}

String _$categoriesControllerHash() =>
    r'288f98c23750449b9fd6a4e3807b7edc1e2dfe79';

/// O'z turlarini yaratish va o'chirish.

abstract class _$CategoriesController extends $AsyncNotifier<void> {
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
