import 'dart:math' as math;

import 'important_event.dart';

/// Muhim kunning aniq sanadagi "sodir bo'lishi": qachon, necha kun qoldi,
/// necha yosh / necha yillik. Barcha hisob — sof funksiyalar (testlangan).
class EventOccurrence {
  const EventOccurrence({
    required this.event,
    required this.date,
    required this.daysUntil,
    this.yearsCount,
  });

  final ImportantEvent event;
  final DateTime date;

  /// 0 — bugun, 1 — ertaga, manfiy — o'tib ketgan (bir martalik uchrashuv).
  final int daysUntil;

  /// Tug'ilgan kun: necha yoshga to'ladi; to'y: necha yillik. Yili noma'lum — null.
  final int? yearsCount;

  bool get isToday => daysUntil == 0;
  bool get isPast => daysUntil < 0;
}

abstract final class EventDates {
  static bool isLeapYear(int year) =>
      (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;

  static int daysInMonth(int year, int month) =>
      DateTime.utc(year, month + 1, 0).day;

  /// Berilgan yildagi sana. 29-fevral kabisa bo'lmagan yilda — 28-fevral.
  static DateTime inYear(ImportantEvent event, int year) {
    final day = math.min(event.day, daysInMonth(year, event.month));
    return DateTime(year, event.month, day);
  }

  /// Keyingi sana (bugun ham hisobga kiradi). Bir martalik — o'z sanasi.
  static DateTime next(ImportantEvent event, DateTime today) {
    final day = DateTime(today.year, today.month, today.day);
    if (!event.repeatYearly && event.year != null) {
      return inYear(event, event.year!);
    }
    final thisYear = inYear(event, day.year);
    return thisYear.isBefore(day) ? inYear(event, day.year + 1) : thisYear;
  }

  /// Ikki sana orasidagi kunlar (yozgi vaqtga o'tish xatosisiz — UTC'da).
  static int daysBetween(DateTime from, DateTime to) {
    final a = DateTime.utc(from.year, from.month, from.day);
    final b = DateTime.utc(to.year, to.month, to.day);
    return b.difference(a).inDays;
  }

  static EventOccurrence occurrence(ImportantEvent event, DateTime today) {
    final date = next(event, today);
    return EventOccurrence(
      event: event,
      date: date,
      daysUntil: daysBetween(today, date),
      yearsCount: _years(event, date),
    );
  }

  /// Hammasini sanasi bo'yicha: avval kelayotganlar (yaqinidan), oxirida
  /// o'tib ketgan bir martalik uchrashuvlar (yangisidan).
  static List<EventOccurrence> sorted(
    Iterable<ImportantEvent> events,
    DateTime today,
  ) {
    final all = events.map((e) => occurrence(e, today)).toList();
    final upcoming = all.where((o) => !o.isPast).toList()
      ..sort((a, b) => a.daysUntil.compareTo(b.daysUntil));
    final past = all.where((o) => o.isPast).toList()
      ..sort((a, b) => b.daysUntil.compareTo(a.daysUntil));
    return [...upcoming, ...past];
  }

  /// Taqvim uchun: berilgan oydagi kunlar va o'sha kungi muhim kunlar.
  static Map<int, List<ImportantEvent>> inMonth(
    Iterable<ImportantEvent> events,
    int year,
    int month,
  ) {
    final result = <int, List<ImportantEvent>>{};
    for (final event in events) {
      if (event.month != month) continue;
      if (event.repeatYearly) {
        if (event.year != null && year < event.year!) continue;
      } else if (event.year != year) {
        continue;
      }
      final day = inYear(event, year).day;
      (result[day] ??= []).add(event);
    }
    return result;
  }

  static int? _years(ImportantEvent event, DateTime date) {
    if (!event.repeatYearly || event.year == null) return null;
    if (!event.category.countsYears) return null;
    final years = date.year - event.year!;
    return years > 0 ? years : null;
  }
}
