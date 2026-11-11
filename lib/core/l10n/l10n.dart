import 'package:material_ui/material_ui.dart';

import '../../l10n/gen/app_localizations.dart';

export '../../l10n/gen/app_localizations.dart' show AppLocalizations;

/// Matnlarga qisqa yo'l: `context.l10n.navHome`.
///
/// Barcha matnlar `lib/l10n/app_uz.arb` (asosiy), `app_ru.arb`, `app_en.arb`
/// fayllarida. Widget ichida qo'lda yozilgan matn bo'lmaydi.
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
