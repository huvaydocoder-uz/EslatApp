import 'package:material_ui/material_ui.dart';

import '../l10n/l10n.dart';

/// Foydalanuvchi tanlay oladigan asosiy (seed) ranglar.
///
/// Material 3 bitta "seed" rangdan butun palitrani (fon, tugma, karta,
/// tungi rejim) avtomatik va kontrast talablariga mos holda yaratadi.
/// Keksa foydalanuvchilar uchun murakkab "color wheel" o'rniga 12 ta
/// aniq, katta rang doirachasi ko'rsatiladi.
class PaletteColor {
  const PaletteColor(this.color, this.label);

  final Color color;

  /// Ekran o'quvchilari (TalkBack/VoiceOver) uchun rang nomi — joriy tilda.
  final String Function(AppLocalizations l10n) label;
}

abstract final class AppPalette {
  static const int defaultSeedValue = 0xFF3F51B5;
  static const Color defaultSeed = Color(defaultSeedValue);

  static final List<PaletteColor> colors = [
    PaletteColor(defaultSeed, (l) => l.colorIndigo),
    PaletteColor(const Color(0xFF1E88E5), (l) => l.colorBlue),
    PaletteColor(const Color(0xFF00897B), (l) => l.colorTeal),
    PaletteColor(const Color(0xFF43A047), (l) => l.colorGreen),
    PaletteColor(const Color(0xFF7C8B3C), (l) => l.colorOlive),
    PaletteColor(const Color(0xFFFFB300), (l) => l.colorAmber),
    PaletteColor(const Color(0xFFF4511E), (l) => l.colorOrange),
    PaletteColor(const Color(0xFFFF7262), (l) => l.colorCoral),
    PaletteColor(const Color(0xFFE53935), (l) => l.colorRed),
    PaletteColor(const Color(0xFFD81B60), (l) => l.colorPink),
    PaletteColor(const Color(0xFF8E24AA), (l) => l.colorPurple),
    PaletteColor(const Color(0xFF795548), (l) => l.colorBrown),
  ];
}
