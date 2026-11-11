import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/data/auth_repository.dart';
import '../data/categories_repository.dart';
import '../domain/custom_category.dart';

part 'categories_controller.g.dart';

/// O'z turlarini yaratish va o'chirish.
@riverpod
class CategoriesController extends _$CategoriesController {
  @override
  FutureOr<void> build() {}

  /// Yangi tur ID si; xato bo'lsa — `null`.
  Future<String?> create(String name, String emoji) async {
    final user = ref.read(authStateProvider).value;
    final trimmed = name.trim();
    if (user == null || trimmed.isEmpty) return null;
    final category = CustomCategory(
      name: trimmed.length > 40 ? trimmed.substring(0, 40) : trimmed,
      emoji: emoji,
    );
    try {
      return await ref
          .read(categoriesRepositoryProvider)
          .create(user.uid, category);
    } on Exception {
      return null;
    }
  }

  Future<void> delete(String categoryId) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(categoriesRepositoryProvider).delete(user.uid, categoryId),
    );
    if (ref.mounted) state = result;
  }
}
