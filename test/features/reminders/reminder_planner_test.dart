import 'package:eslat/features/events/domain/event_category.dart';
import 'package:eslat/features/events/domain/important_event.dart';
import 'package:eslat/features/reminders/domain/reminder_planner.dart';
import 'package:flutter_test/flutter_test.dart';

final texts = ReminderTexts(
  body: (o, d) => 'd=$d',
  smsSentTitle: 'sent',
  smsFailedTitle: 'failed',
);

ImportantEvent event({
  String id = 'e1',
  int day = 14,
  int month = 3,
  List<int> remind = const [0, 1],
  String notifyTime = '09:30',
  bool repeat = true,
  int? year,
  SmsMode sms = SmsMode.off,
  bool alarm = true,
}) => ImportantEvent(
  id: id,
  title: 'Onam',
  category: EventCategory.parentBirthday,
  emoji: '👵',
  day: day,
  month: month,
  year: year,
  repeatYearly: repeat,
  remindDaysBefore: remind,
  notifyTime: notifyTime,
  alarmEnabled: alarm,
  smsMode: sms,
  phone: sms == SmsMode.off ? null : '+998901234567',
  smsText: sms == SmsMode.off ? null : "Tug'ilgan kuningiz muborak!",
);

void main() {
  final now = DateTime(2026, 3, 10, 12);

  test('har bir eslatma o\'z kunida, eslatish vaqtida', () {
    final plan = ReminderPlanner.plan([event()], now, texts);
    expect(plan.map((r) => r.at), [
      DateTime(2026, 3, 13, 9, 30),
      DateTime(2026, 3, 14, 9, 30),
    ]);
    expect(plan.first.title, '👵 Onam');
    expect(plan.first.route, '/event/e1');
    expect(plan.map((r) => r.body), ['d=1', 'd=0']);
  });

  test('bugungi vaqti o\'tgan eslatma — kelasi yilga (har yilgi)', () {
    final plan = ReminderPlanner.plan(
      [
        event(day: 10, remind: const [0], notifyTime: '09:00'),
      ],
      now,
      texts,
    );
    expect(plan.single.at, DateTime(2027, 3, 10, 9));
  });

  test('bugun, vaqti hali kelmagan — bugun', () {
    final plan = ReminderPlanner.plan(
      [
        event(day: 10, remind: const [0], notifyTime: '18:00'),
      ],
      now,
      texts,
    );
    expect(plan.single.at, DateTime(2026, 3, 10, 18));
  });

  test('o\'tib ketgan bir martalik uchrashuv — eslatma yo\'q', () {
    final plan = ReminderPlanner.plan(
      [event(day: 1, year: 2026, repeat: false)],
      now,
      texts,
    );
    expect(plan, isEmpty);
  });

  test(
    'avtomatik SMS faqat o\'sha kuni; "o\'sha kuni" tanlanmagan bo\'lsa ham',
    () {
      final plan = ReminderPlanner.plan(
        [
          event(remind: const [1], sms: SmsMode.device),
        ],
        now,
        texts,
      );
      expect(plan, hasLength(2));
      final dayBefore = plan.first;
      final onDay = plan.last;
      expect(dayBefore.hasSms, isFalse);
      expect(onDay.at, DateTime(2026, 3, 14, 9, 30));
      expect(onDay.smsPhone, '+998901234567');
      expect(onDay.smsText, "Tug'ilgan kuningiz muborak!");
      expect(onDay.smsSentTitle, 'sent');
    },
  );

  test('server SMS (auto) yoki o\'chiq — telefon SMS yubormaydi', () {
    for (final mode in [SmsMode.off, SmsMode.auto, SmsMode.manual]) {
      final plan = ReminderPlanner.plan([event(sms: mode)], now, texts);
      expect(plan.any((r) => r.hasSms), isFalse, reason: '$mode');
    }
  });

  test('id barqaror, turli eslatmalar uchun turlicha, musbat', () {
    final a = ReminderPlanner.plan([event()], now, texts);
    final b = ReminderPlanner.plan([event()], now, texts);
    expect(a.map((r) => r.id), b.map((r) => r.id));
    expect(a.map((r) => r.id).toSet(), hasLength(2));
    expect(a.every((r) => r.id > 0 && r.id < 0x40000000), isTrue);
  });

  test('toMap — Android tomoni kutgan maydonlar', () {
    final map = ReminderPlanner.plan(
      [event(sms: SmsMode.device)],
      now,
      texts,
    ).last.toMap();
    expect(map.keys, containsAll(['id', 'at', 'title', 'body', 'route']));
    expect(map['at'], DateTime(2026, 3, 14, 9, 30).millisecondsSinceEpoch);
    expect(map['repeatYearly'], isTrue);
  });

  test('budilnik faqat o\'sha kuni, budilnik sahifasini ochadi', () {
    final plan = ReminderPlanner.plan([event()], now, texts);
    final dayBefore = plan.first;
    final onDay = plan.last;
    expect(dayBefore.alarm, isFalse);
    expect(dayBefore.route, '/event/e1');
    expect(onDay.alarm, isTrue);
    expect(onDay.route, '/alarm/e1');
    expect(onDay.toMap()['alarm'], isTrue);
  });

  test(
    'budilnik o\'chiq — oddiy eslatma; "o\'sha kuni" tanlanmasa qo\'shilmaydi',
    () {
      final off = ReminderPlanner.plan([event(alarm: false)], now, texts);
      expect(off.any((r) => r.alarm), isFalse);
      final onlyBefore = ReminderPlanner.plan(
        [
          event(alarm: false, remind: const [1]),
        ],
        now,
        texts,
      );
      expect(onlyBefore, hasLength(1));
    },
  );

  test('budilnik yoqiq — "o\'sha kuni" tanlanmagan bo\'lsa ham chaladi', () {
    final plan = ReminderPlanner.plan(
      [
        event(remind: const [7]),
      ],
      now,
      texts,
    );
    // 7 kun oldingisi bu yil o'tib ketgan — kelasi yilga; o'sha kuni — bu yil.
    expect(plan, hasLength(2));
    expect(plan.singleWhere((r) => r.alarm).at, DateTime(2026, 3, 14, 9, 30));
  });
}
