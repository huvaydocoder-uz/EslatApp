import 'package:eslat/core/theme/app_palette.dart';
import 'package:eslat/core/theme/app_theme.dart';
import 'package:eslat/core/theme/theme_controller.dart';
import 'package:eslat/core/theme/theme_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  group('ThemeController', () {
    late ProviderContainer container;
    ThemeSettings read() => container.read(themeControllerProvider);
    ThemeController controller() =>
        container.read(themeControllerProvider.notifier);

    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('rejim va palitradagi rangni o\'zgartiradi', () {
      final teal = AppPalette.colors[2].color;
      controller()
        ..setThemeMode(ThemeMode.dark)
        ..setSeedColor(teal);

      expect(read().themeMode, ThemeMode.dark);
      expect(read().isSelected(teal), isTrue);
    });

    test('palitrada yo\'q rangni qabul qilmaydi', () {
      controller().setSeedColor(const Color(0xFF123456));
      expect(read(), ThemeSettings.defaults);
    });

    test('buzilgan saqlangan rangni standartga qaytaradi', () {
      controller().restore(
        const ThemeSettings(
          themeMode: ThemeMode.light,
          seedColorValue: 0xFF123456,
        ),
      );
      expect(read().themeMode, ThemeMode.light);
      expect(read().seedColorValue, AppPalette.defaultSeedValue);
    });
  });
}
