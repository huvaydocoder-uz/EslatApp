import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/l10n/app_language.dart';
import '../../../core/theme/theme_settings.dart';
import '../../subscription/domain/plan.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// `users/{uid}` hujjati (docs/FIRESTORE.md, firebase/firestore.rules).
///
/// `plan`ni faqat server o'zgartiradi — ilova uni faqat o'qiydi.
/// `createdAt`/`updatedAt` repository'da server vaqti bilan qo'shiladi.
@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    String? displayName,
    String? email,
    String? photoUrl,
    @Default('uz') String locale,
    @Default(AppConstants.defaultTimezone) String timezone,
    @JsonKey(unknownEnumValue: AppPlan.free)
    @Default(AppPlan.free)
    AppPlan plan,
    @Default(ThemeSettings.defaults) ThemeSettings settings,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  AppLanguage get language => AppLanguage.fromCode(locale);
}
