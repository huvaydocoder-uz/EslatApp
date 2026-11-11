import 'package:eslat/features/events/domain/event_category.dart';
import 'package:eslat/features/events/domain/important_event.dart';
import 'package:eslat/features/events/domain/phone_number.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneNumber.normalize', () {
    test('O\'zbekiston raqami har xil yozilganda ham bir xil natija', () {
      for (final input in [
        '90 123 45 67',
        '+998 (90) 123-45-67',
        '998901234567',
        '+998901234567',
      ]) {
        expect(PhoneNumber.normalize(input), '+998901234567', reason: input);
      }
    });

    test('xalqaro raqam saqlanadi', () {
      expect(PhoneNumber.normalize('+7 912 345 67 89'), '+79123456789');
    });

    test('noto\'g\'ri raqam — null', () {
      for (final input in ['', 'abc', '123', '+0123456789']) {
        expect(PhoneNumber.normalize(input), isNull, reason: input);
      }
    });
  });

  group('Firestore JSON (firebase/firestore.rules bilan mos)', () {
    const allowedKeys = {
      'title',
      'personName',
      'category',
      'emoji',
      'day',
      'month',
      'year',
      'time',
      'repeatYearly',
      'remindDaysBefore',
      'notifyTime',
      'alarmEnabled',
      'smsMode',
      'phone',
      'smsText',
      'note',
      'nextReminderAt',
    };

    test('faqat ruxsat etilgan maydonlar, id va null qiymatlar yozilmaydi', () {
      const event = ImportantEvent(
        id: 'abc',
        title: 'Test',
        category: EventCategory.parentBirthday,
        emoji: '👵',
        day: 14,
        month: 3,
      );
      final json = event.toJson();
      expect(
        allowedKeys.containsAll(json.keys),
        isTrue,
        reason: '${json.keys}',
      );
      expect(json.containsKey('id'), isFalse);
      expect(json.containsKey('year'), isFalse);
      expect(json['category'], 'parentBirthday');
      expect(json['smsMode'], 'off');
      expect(json['remindDaysBefore'], [0, 1]);
    });

    test('ikki tomonga o\'giriladi, noma\'lum qiymatlar xavfsiz', () {
      const event = ImportantEvent(
        title: 'Test',
        category: EventCategory.meeting,
        emoji: '📅',
        day: 1,
        month: 12,
        year: 2026,
        time: '14:30',
        repeatYearly: false,
        smsMode: SmsMode.manual,
        phone: '+998901234567',
      );
      expect(ImportantEvent.fromJson(event.toJson()), event);
      final odd = ImportantEvent.fromJson({
        ...event.toJson(),
        'category': 'party',
        'smsMode': 'pigeon',
      });
      expect(odd.category, EventCategory.other);
      expect(odd.smsMode, SmsMode.off);
    });

    test('barcha emojilar Firestore chegarasiga (16) sig\'adi', () {
      for (final emoji in eventEmojis) {
        expect(emoji.length, lessThanOrEqualTo(16), reason: emoji);
      }
    });
  });
}
