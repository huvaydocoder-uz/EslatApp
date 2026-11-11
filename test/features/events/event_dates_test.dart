import 'package:eslat/features/events/domain/event_category.dart';
import 'package:eslat/features/events/domain/event_occurrence.dart';
import 'package:eslat/features/events/domain/important_event.dart';
import 'package:flutter_test/flutter_test.dart';

ImportantEvent event({
  int day = 14,
  int month = 3,
  int? year,
  bool repeat = true,
  EventCategory category = EventCategory.birthday,
}) => ImportantEvent(
  title: 'x',
  category: category,
  emoji: '🎂',
  day: day,
  month: month,
  year: year,
  repeatYearly: repeat,
);

void main() {
  final today = DateTime(2026, 3, 10);

  group('keyingi sana', () {
    test('shu yil hali kelmagan — shu yil', () {
      final o = EventDates.occurrence(event(), today);
      expect(o.date, DateTime(2026, 3, 14));
      expect(o.daysUntil, 4);
    });

    test('bugun — 0 kun', () {
      final o = EventDates.occurrence(event(day: 10), today);
      expect(o.isToday, isTrue);
    });

    test('shu yil o\'tib ketgan — kelasi yil', () {
      final o = EventDates.occurrence(event(day: 9), today);
      expect(o.date, DateTime(2027, 3, 9));
      expect(o.daysUntil, 364);
    });

    test('29-fevral kabisa bo\'lmagan yilda — 28-fevral', () {
      final o = EventDates.occurrence(
        event(day: 29, month: 2),
        DateTime(2026, 1, 1),
      );
      expect(o.date, DateTime(2026, 2, 28));
      final leap = EventDates.occurrence(
        event(day: 29, month: 2),
        DateTime(2028, 1, 1),
      );
      expect(leap.date, DateTime(2028, 2, 29));
    });

    test('bir martalik uchrashuv — o\'z sanasi, o\'tgan bo\'lsa manfiy', () {
      final meeting = event(
        year: 2026,
        day: 1,
        repeat: false,
        category: EventCategory.meeting,
      );
      final o = EventDates.occurrence(meeting, today);
      expect(o.date, DateTime(2026, 3, 1));
      expect(o.daysUntil, -9);
      expect(o.isPast, isTrue);
    });

    test('yozgi vaqtga o\'tish kuni kun soni buzilmaydi', () {
      expect(
        EventDates.daysBetween(DateTime(2026, 3, 28), DateTime(2026, 3, 30)),
        2,
      );
      expect(
        EventDates.daysBetween(DateTime(2026, 10, 24), DateTime(2026, 10, 26)),
        2,
      );
    });
  });

  group('yosh va yillik', () {
    test('tug\'ilgan yil ma\'lum — necha yoshga to\'ladi', () {
      expect(EventDates.occurrence(event(year: 1966), today).yearsCount, 60);
    });

    test('yil noma\'lum yoki uchrashuv — sanalmaydi', () {
      expect(EventDates.occurrence(event(), today).yearsCount, isNull);
      final meeting = event(year: 2020, category: EventCategory.meeting);
      expect(EventDates.occurrence(meeting, today).yearsCount, isNull);
    });
  });

  test('saralash: yaqinlari oldin, o\'tgan uchrashuvlar oxirida', () {
    final sorted = EventDates.sorted([
      event(day: 20),
      event(year: 2026, day: 1, repeat: false, category: EventCategory.meeting),
      event(day: 11),
      event(day: 10),
    ], today);
    expect(sorted.map((o) => o.daysUntil), [0, 1, 10, -9]);
  });

  test(
    'taqvim: oydagi kunlar, tug\'ilishdan oldingi yillar ko\'rsatilmaydi',
    () {
      final birthday = event(day: 14, year: 2026);
      expect(EventDates.inMonth([birthday], 2026, 3).keys, [14]);
      expect(EventDates.inMonth([birthday], 2025, 3), isEmpty);
      expect(EventDates.inMonth([birthday], 2026, 4), isEmpty);
      final once = event(day: 5, year: 2026, repeat: false);
      expect(EventDates.inMonth([once], 2027, 3), isEmpty);
    },
  );
}
