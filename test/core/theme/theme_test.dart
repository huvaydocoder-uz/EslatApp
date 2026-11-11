import 'package:eslat/core/theme/app_palette.dart';
import 'package:eslat/core/theme/app_theme.dart';
import 'package:eslat/core/theme/theme_settings.dart';
import 'package:eslat/l10n/gen/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('AppTheme', () {
    test('kunduzgi va tungi rejim Material 3 bilan yaratiladi', () {
      final light = AppTheme.light(AppPalette.defaultSeed);
      final dark = AppTheme.dark(AppPalette.defaultSeed);

      expect(light.useMaterial3, isTrue);
      expect(light.colorScheme.brightness, Brightness.light);
      expect(dark.colorScheme.brightness, Brightness.dark);
    });

    test('har bir palitra rangi alohida sxema beradi', () {
      final primaries = AppPalette.colors
          .map((c) => AppTheme.light(c.color).colorScheme.primary)
          .toSet();
      expect(primaries.length, AppPalette.colors.length);
    });

    test('katta shrift va katta pastki menyu', () {
      final theme = AppTheme.light(AppPalette.defaultSeed);
      expect(theme.textTheme.bodyLarge!.fontSize, greaterThanOrEqualTo(18));
      expect(theme.navigationBarTheme.height, greaterThanOrEqualTo(80));
      expect(
        theme.navigationBarTheme.labelBehavior,
        NavigationDestinationLabelBehavior.alwaysShow,
      );
    });
  });

  group('ThemeSettings', () {
    test('JSON (Firestore) bilan ikki tomonga to\'g\'ri o\'giriladi', () {
      const settings = ThemeSettings(
        themeMode: ThemeMode.dark,
        seedColorValue: 0xFF00897B,
      );
      final json = settings.toJson();
      expect(json, {'themeMode': 'dark', 'seedColor': 0xFF00897B});
      expect(ThemeSettings.fromJson(json), settings);
    });

    test('bo\'sh JSON standart qiymatlarni beradi', () {
      expect(ThemeSettings.fromJson(const {}), ThemeSettings.defaults);
    });
  });

  group('ThemeSettings.sanitized', () {
    test('profil yo\'q — standart mavzu', () {
      expect(ThemeSettings.sanitized(null), ThemeSettings.defaults);
    });

    test('palitradagi rang saqlanadi', () {
      const saved = ThemeSettings(
        themeMode: ThemeMode.dark,
        seedColorValue: 0xFF00897B,
      );
      expect(ThemeSettings.sanitized(saved), saved);
    });

    test('palitrada yo\'q rang standartga qaytadi, rejim saqlanadi', () {
      final result = ThemeSettings.sanitized(
        const ThemeSettings(
          themeMode: ThemeMode.light,
          seedColorValue: 0xFF123456,
        ),
      );
      expect(result.themeMode, ThemeMode.light);
      expect(result.seedColorValue, AppPalette.defaultSeedValue);
    });

    test('noma\'lum themeMode qiymati — tizim rejimi', () {
      final result = ThemeSettings.fromJson(const {'themeMode': 'neon'});
      expect(result.themeMode, ThemeMode.system);
    });
  });

  test('palitra: 12 ta noyob rang, har birining 3 tilda nomi bor', () {
    final values = AppPalette.colors.map((c) => c.color.toARGB32()).toSet();
    expect(values.length, 12);
    for (final code in ['uz', 'ru', 'en']) {
      final l10n = lookupAppLocalizations(Locale(code));
      for (final color in AppPalette.colors) {
        expect(color.label(l10n), isNotEmpty);
      }
    }
  });
}
