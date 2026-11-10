import 'package:material_ui/material_ui.dart';

import '../constants/app_strings.dart';

/// Foydalanuvchi tanlay oladigan asosiy (seed) ranglar.
///
/// Material 3 bitta "seed" rangdan butun palitrani (fon, tugma, karta,
/// tungi rejim) avtomatik va kontrast talablariga mos holda yaratadi.
/// Keksa foydalanuvchilar uchun murakkab "color wheel" o'rniga 12 ta
/// aniq, katta rang doirachasi ko'rsatiladi.
class PaletteColor {
  const PaletteColor(this.color, this.label);

  final Color color;

  /// Ekran o'quvchilari (TalkBack/VoiceOver) uchun rang nomi.
  final String label;
}

abstract final class AppPalette {
  static const int defaultSeedValue = 0xFF3F51B5;
  static const Color defaultSeed = Color(defaultSeedValue);

  static const List<PaletteColor> colors = [
    PaletteColor(defaultSeed, AppStrings.colorIndigo),
    PaletteColor(Color(0xFF1E88E5), AppStrings.colorBlue),
    PaletteColor(Color(0xFF00897B), AppStrings.colorTeal),
    PaletteColor(Color(0xFF43A047), AppStrings.colorGreen),
    PaletteColor(Color(0xFF7C8B3C), AppStrings.colorOlive),
    PaletteColor(Color(0xFFFFB300), AppStrings.colorAmber),
    PaletteColor(Color(0xFFF4511E), AppStrings.colorOrange),
    PaletteColor(Color(0xFFFF7262), AppStrings.colorCoral),
    PaletteColor(Color(0xFFE53935), AppStrings.colorRed),
    PaletteColor(Color(0xFFD81B60), AppStrings.colorPink),
    PaletteColor(Color(0xFF8E24AA), AppStrings.colorPurple),
    PaletteColor(Color(0xFF795548), AppStrings.colorBrown),
  ];
}
