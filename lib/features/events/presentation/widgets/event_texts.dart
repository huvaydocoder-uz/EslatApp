import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/event_category.dart';
import '../../domain/event_occurrence.dart';

/// Muhim kun haqidagi matnlar — barcha ekranlarda bir xil.
abstract final class EventTexts {
  /// "Bugun!", "Ertaga", "5 kundan keyin", "3 kun oldin o'tdi".
  static String relative(AppLocalizations l10n, int daysUntil) {
    if (daysUntil == 0) return l10n.today;
    if (daysUntil == 1) return l10n.tomorrow;
    if (daysUntil > 1) return l10n.daysLeft(daysUntil);
    return l10n.daysAgo(-daysUntil);
  }

  /// "30 yoshga to'ladi" yoki "10 yillik"; yili noma'lum bo'lsa — null.
  static String? years(AppLocalizations l10n, EventOccurrence o) {
    final years = o.yearsCount;
    if (years == null) return null;
    return o.event.category == EventCategory.anniversary
        ? l10n.anniversaryYears(years)
        : l10n.turnsAge(years);
  }

  /// "14-mart" (har yili) yoki "14-mart, 2026" (bir martalik) + vaqt.
  static String date(BuildContext context, EventOccurrence o) {
    final loc = MaterialLocalizations.of(context);
    final day = o.event.repeatYearly
        ? loc.formatShortMonthDay(o.date)
        : loc.formatMediumDate(o.date);
    final time = o.event.time;
    if (time == null) return day;
    final parts = time.split(':');
    final formatted = loc.formatTimeOfDay(
      TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])),
      alwaysUse24HourFormat: true,
    );
    return '$day, $formatted';
  }
}
