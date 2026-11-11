// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThemeSettings _$ThemeSettingsFromJson(Map<String, dynamic> json) =>
    _ThemeSettings(
      themeMode:
          $enumDecodeNullable(
            _$ThemeModeEnumMap,
            json['themeMode'],
            unknownValue: ThemeMode.system,
          ) ??
          ThemeMode.system,
      seedColorValue:
          (json['seedColor'] as num?)?.toInt() ?? AppPalette.defaultSeedValue,
    );

Map<String, dynamic> _$ThemeSettingsToJson(_ThemeSettings instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'seedColor': instance.seedColorValue,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
