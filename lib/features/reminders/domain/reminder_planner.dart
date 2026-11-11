import '../../events/domain/event_occurrence.dart';
import '../../events/domain/important_event.dart';
import 'scheduled_reminder.dart';

/// Bildirishnoma matnlari (3 tilda) — presentation qatlami beradi.
class ReminderTexts {
  const ReminderTexts({
    required this.body,
    required this.smsSentTitle,
    required this.smsFailedTitle,
  });

  /// [daysBefore]: 0 — bugun; [occurrence] — o'sha kungi sana va yosh.
  final String Function(EventOccurrence occurrence, int daysBefore) body;
  final String smsSentTitle;
  final String smsFailedTitle;
}

/// Muhim kunlardan telefonga qo'yiladigan eslatmalar ro'yxati.
///
/// - Har bir "necha kun oldin" uchun bittadan, `notifyTime` soatida.
/// - Avtomatik SMS (`SmsMode.device`) va musiqali budilnik (`alarmEnabled`) —
///   faqat o'sha kunning o'zida; "o'sha kuni" eslatmasi tanlanmagan bo'lsa ham
///   ular uchun qo'shiladi.
/// - Vaqti o'tgan bo'lsa: har yilgisi — kelasi yilga, bir martaligi — tashlanadi.
abstract final class ReminderPlanner {
  /// Android bir ilova uchun 500 tagacha alarm ruxsat beradi.
  static const maxReminders = 400;

  static List<ScheduledReminder> plan(
    Iterable<ImportantEvent> events,
    DateTime now,
    ReminderTexts texts,
  ) {
    final today = DateTime(now.year, now.month, now.day);
    final result = <ScheduledReminder>[];
    for (final event in events) {
      final sends =
          event.smsMode == SmsMode.device &&
          event.phone != null &&
          (event.smsText?.trim().isNotEmpty ?? false);
      final offsets = {
        ...event.remindDaysBefore,
        if (sends || event.alarmEnabled) 0,
      };
      for (final daysBefore in offsets) {
        final reminder = _reminder(event, daysBefore, today, now, texts, sends);
        if (reminder != null) result.add(reminder);
      }
    }
    result.sort((a, b) => a.at.compareTo(b.at));
    return result.take(maxReminders).toList();
  }

  static ScheduledReminder? _reminder(
    ImportantEvent event,
    int daysBefore,
    DateTime today,
    DateTime now,
    ReminderTexts texts,
    bool sends,
  ) {
    var occurrence = EventDates.occurrence(event, today);
    var at = _fireTime(occurrence.date, daysBefore, event.notifyTime);
    if (!at.isAfter(now)) {
      if (!event.repeatYearly) return null;
      final nextYear = DateTime(occurrence.date.year + 1, 1, 1);
      occurrence = EventDates.occurrence(event, nextYear);
      at = _fireTime(occurrence.date, daysBefore, event.notifyTime);
    }
    final withSms = sends && daysBefore == 0;
    final alarm = event.alarmEnabled && daysBefore == 0;
    return ScheduledReminder(
      id: stableId('${event.id}#$daysBefore'),
      at: at,
      title: '${event.emoji} ${event.title}',
      body: texts.body(occurrence, daysBefore),
      route: alarm ? '/alarm/${event.id}' : '/event/${event.id}',
      repeatYearly: event.repeatYearly,
      alarm: alarm,
      smsPhone: withSms ? event.phone : null,
      smsText: withSms ? event.smsText!.trim() : null,
      smsSentTitle: withSms ? texts.smsSentTitle : null,
      smsFailedTitle: withSms ? texts.smsFailedTitle : null,
    );
  }

  static DateTime _fireTime(DateTime date, int daysBefore, String hhmm) {
    final parts = hhmm.split(':');
    final hour = int.tryParse(parts.first) ?? 9;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return DateTime(date.year, date.month, date.day - daysBefore, hour, minute);
  }

  /// FNV-1a (32 bit), musbat int — Android `PendingIntent` kodi uchun.
  static int stableId(String key) {
    var hash = 0x811c9dc5;
    for (final unit in key.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return hash & 0x3fffffff;
  }
}
