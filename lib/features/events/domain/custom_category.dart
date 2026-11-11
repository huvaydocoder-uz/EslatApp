import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_category.freezed.dart';
part 'custom_category.g.dart';

/// Foydalanuvchi o'zi yaratgan muhim kun turi (`users/{uid}/categories/{id}`),
/// masalan "Ish yubileyi 🏆". Firestore: nomi ≤40, emoji ≤16 belgi.
@freezed
abstract class CustomCategory with _$CustomCategory {
  const factory CustomCategory({
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default('')
    String id,
    required String name,
    required String emoji,
  }) = _CustomCategory;

  factory CustomCategory.fromJson(Map<String, dynamic> json) =>
      _$CustomCategoryFromJson(json);
}
