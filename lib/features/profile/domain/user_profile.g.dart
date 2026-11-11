// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  displayName: json['displayName'] as String?,
  email: json['email'] as String?,
  photoUrl: json['photoUrl'] as String?,
  locale: json['locale'] as String? ?? 'uz',
  timezone: json['timezone'] as String? ?? AppConstants.defaultTimezone,
  plan:
      $enumDecodeNullable(
        _$AppPlanEnumMap,
        json['plan'],
        unknownValue: AppPlan.free,
      ) ??
      AppPlan.free,
  settings: json['settings'] == null
      ? ThemeSettings.defaults
      : ThemeSettings.fromJson(json['settings'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'displayName': ?instance.displayName,
      'email': ?instance.email,
      'photoUrl': ?instance.photoUrl,
      'locale': instance.locale,
      'timezone': instance.timezone,
      'plan': _$AppPlanEnumMap[instance.plan]!,
      'settings': instance.settings.toJson(),
    };

const _$AppPlanEnumMap = {AppPlan.free: 'free', AppPlan.pro: 'pro'};
