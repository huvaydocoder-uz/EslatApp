import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../domain/event_category.dart';

/// Toifaning ekrandagi ko'rinishi (domen modeli UI'ga bog'lanmaydi).
extension EventCategoryUi on EventCategory {
  IconData get icon => switch (this) {
    EventCategory.birthday => Icons.cake_rounded,
    EventCategory.anniversary => Icons.favorite_rounded,
    EventCategory.parentBirthday => Icons.elderly_rounded,
    EventCategory.meeting => Icons.event_rounded,
    EventCategory.other => Icons.star_rounded,
  };

  String label(AppLocalizations l10n) => switch (this) {
    EventCategory.birthday => l10n.categoryBirthday,
    EventCategory.anniversary => l10n.categoryAnniversary,
    EventCategory.parentBirthday => l10n.categoryParentBirthday,
    EventCategory.meeting => l10n.categoryMeeting,
    EventCategory.other => l10n.categoryOther,
  };
}
