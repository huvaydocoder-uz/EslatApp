import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_category.dart';

part 'important_event.freezed.dart';
part 'important_event.g.dart';

/// SMS rejimi (Firestore `smsMode`):
/// - `device` — o'sha kuni eslatish vaqtida foydalanuvchining o'z telefonidan
///   avtomatik yuboriladi (bepul, Android);
/// - `manual` — SMS ilovasi tayyor matn bilan ochiladi;
/// - `auto` — server (SMS shlyuz) orqali, faqat Pro (keyinroq, iOS uchun ham).
enum SmsMode { off, manual, device, auto }

/// Eslatish vaqti standarti (soat:daqiqa).
const defaultNotifyTime = '09:00';

/// Eslatma variantlari (kun oldin). Firestore qoidasidagi ro'yxatning qismi.
const reminderOptions = <int>[0, 1, 3, 7];

/// `users/{uid}/events/{id}` hujjati. Maydonlar: docs/FIRESTORE.md.
///
/// Sana `day`/`month`/`year` bo'lib saqlanadi: tug'ilgan kun har yili
/// takrorlanadi, yili esa ko'pincha noma'lum.
@freezed
abstract class ImportantEvent with _$ImportantEvent {
  const ImportantEvent._();

  const factory ImportantEvent({
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default('')
    String id,
    required String title,
    String? personName,
    @JsonKey(unknownEnumValue: EventCategory.other)
    required EventCategory category,

    /// Foydalanuvchi yaratgan tur (`users/{uid}/categories/{id}`); bo'lsa,
    /// `category` = `other`.
    String? customCategoryId,
    required String emoji,
    required int day,
    required int month,
    int? year,
    String? time,
    @Default(true) bool repeatYearly,
    @Default(<int>[0, 1]) List<int> remindDaysBefore,

    /// Eslatma (va avtomatik SMS) shu vaqtda: "HH:mm".
    @Default(defaultNotifyTime) String notifyTime,
    @Default(true) bool alarmEnabled,
    @JsonKey(unknownEnumValue: SmsMode.off)
    @Default(SmsMode.off)
    SmsMode smsMode,
    String? phone,
    String? smsText,
    String? note,
  }) = _ImportantEvent;

  factory ImportantEvent.fromJson(Map<String, dynamic> json) =>
      _$ImportantEventFromJson(json);

  /// Yangi kun uchun boshlang'ich qiymat (forma ochilganda).
  factory ImportantEvent.draft(DateTime today) => ImportantEvent(
    title: '',
    category: EventCategory.birthday,
    emoji: EventCategory.birthday.defaultEmoji,
    day: today.day,
    month: today.month,
  );

  /// Ixtiyoriy maydonlar — tahrirlashda bo'shatilsa Firestore'dan o'chiriladi.
  static const optionalFields = [
    'personName',
    'customCategoryId',
    'year',
    'time',
    'phone',
    'smsText',
    'note',
  ];
}
