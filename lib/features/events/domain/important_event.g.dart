// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'important_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImportantEvent _$ImportantEventFromJson(Map<String, dynamic> json) =>
    _ImportantEvent(
      title: json['title'] as String,
      personName: json['personName'] as String?,
      category: $enumDecode(
        _$EventCategoryEnumMap,
        json['category'],
        unknownValue: EventCategory.other,
      ),
      customCategoryId: json['customCategoryId'] as String?,
      emoji: json['emoji'] as String,
      day: (json['day'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num?)?.toInt(),
      time: json['time'] as String?,
      repeatYearly: json['repeatYearly'] as bool? ?? true,
      remindDaysBefore:
          (json['remindDaysBefore'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[0, 1],
      notifyTime: json['notifyTime'] as String? ?? defaultNotifyTime,
      alarmEnabled: json['alarmEnabled'] as bool? ?? true,
      smsMode:
          $enumDecodeNullable(
            _$SmsModeEnumMap,
            json['smsMode'],
            unknownValue: SmsMode.off,
          ) ??
          SmsMode.off,
      phone: json['phone'] as String?,
      smsText: json['smsText'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ImportantEventToJson(_ImportantEvent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'personName': ?instance.personName,
      'category': _$EventCategoryEnumMap[instance.category]!,
      'customCategoryId': ?instance.customCategoryId,
      'emoji': instance.emoji,
      'day': instance.day,
      'month': instance.month,
      'year': ?instance.year,
      'time': ?instance.time,
      'repeatYearly': instance.repeatYearly,
      'remindDaysBefore': instance.remindDaysBefore,
      'notifyTime': instance.notifyTime,
      'alarmEnabled': instance.alarmEnabled,
      'smsMode': _$SmsModeEnumMap[instance.smsMode]!,
      'phone': ?instance.phone,
      'smsText': ?instance.smsText,
      'note': ?instance.note,
    };

const _$EventCategoryEnumMap = {
  EventCategory.birthday: 'birthday',
  EventCategory.anniversary: 'anniversary',
  EventCategory.parentBirthday: 'parentBirthday',
  EventCategory.meeting: 'meeting',
  EventCategory.other: 'other',
};

const _$SmsModeEnumMap = {
  SmsMode.off: 'off',
  SmsMode.manual: 'manual',
  SmsMode.device: 'device',
  SmsMode.auto: 'auto',
};
