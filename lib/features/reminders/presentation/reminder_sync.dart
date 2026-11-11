import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/platform/native_bridge.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../events/data/events_repository.dart';
import '../../events/domain/event_occurrence.dart';
import '../../events/presentation/widgets/event_texts.dart';
import '../../settings/data/app_preferences.dart';
import '../domain/reminder_planner.dart';

part 'reminder_sync.g.dart';

/// Muhim kunlar o'zgarganda telefondagi eslatmalarni (va avtomatik SMS'ni)
/// qayta rejalashtiradi. Chiqilganda ro'yxat bo'sh — hammasi bekor qilinadi.
/// Ma'lumot yuklanayotganda yoki xatoda — mavjud eslatmalarga tegilmaydi.
@Riverpod(keepAlive: true)
class ReminderSync extends _$ReminderSync {
  var _askedNotifications = false;

  @override
  void build() {
    final bridge = ref.watch(nativeBridgeProvider);
    if (!bridge.supportsReminders) return;
    final events = ref.watch(eventsProvider).value;
    if (events == null) return;
    final locale = ref.watch(appLocaleProvider);
    final plan = ReminderPlanner.plan(
      events,
      DateTime.now(),
      reminderTexts(lookupAppLocalizations(locale)),
    );
    unawaited(_apply(bridge, plan.map((r) => r.toMap()).toList()));
  }

  Future<void> _apply(
    NativeBridge bridge,
    List<Map<String, Object?>> reminders,
  ) async {
    try {
      if (reminders.isNotEmpty && !_askedNotifications) {
        _askedNotifications = true;
        await bridge.requestPermission(AppPermission.notifications);
      }
      await bridge.syncReminders(reminders);
    } on Exception catch (error) {
      if (kDebugMode) debugPrint('Eslatmalar rejalashtirilmadi: $error');
    }
  }
}

/// Bildirishnoma matnlari: "Bugun! · 60 yoshga to'ladi · Onam".
ReminderTexts reminderTexts(AppLocalizations l10n) => ReminderTexts(
  body: (EventOccurrence o, int daysBefore) => [
    EventTexts.relative(l10n, daysBefore),
    ?EventTexts.years(l10n, o),
    ?o.event.personName,
  ].join(' · '),
  smsSentTitle: l10n.notifySmsSent,
  smsFailedTitle: l10n.notifySmsFailed,
);
