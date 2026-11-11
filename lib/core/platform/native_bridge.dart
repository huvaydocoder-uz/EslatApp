import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_bridge.g.dart';

enum AppPermission { sms, notifications }

typedef PickedContact = ({String? name, String phone});

/// Telefonning o'z imkoniyatlari: eslatmalar, ruxsatlar, kontakt tanlash.
/// Android'da `MainActivity.kt` ("uz.eslat/native"); boshqa joyda — bo'sh.
abstract interface class NativeBridge {
  /// Muhim kun eslatmalari hozircha faqat Android'da (iOS — keyingi bosqich).
  bool get supportsReminders;

  Future<void> syncReminders(List<Map<String, Object?>> reminders);
  Future<bool> requestPermission(AppPermission permission);

  /// Ilovaning telefon sozlamalaridagi sahifasi (ruxsatlarni qo'lda yoqish).
  Future<void> openAppSettings();

  /// Foydalanuvchi bekor qilsa — `null`.
  Future<PickedContact?> pickContact();

  /// Tanlangan budilnik musiqasi nomi; `null` — standart ovoz.
  Future<String?> alarmSoundName();

  /// Telefon xotirasidan musiqa tanlash. Bekor qilinsa — `null`.
  Future<String?> pickAlarmSound();

  Future<void> resetAlarmSound();

  /// 10 soniya tinglab ko'rish (`false` — to'xtatish).
  Future<void> previewAlarmSound({required bool play});

  /// Chalayotgan budilnikni to'xtatish.
  Future<void> stopAlarm();
}

class AndroidNativeBridge implements NativeBridge {
  static const _channel = MethodChannel('uz.eslat/native');

  @override
  bool get supportsReminders => true;

  @override
  Future<void> syncReminders(List<Map<String, Object?>> reminders) =>
      _channel.invokeMethod('syncReminders', {'reminders': reminders});

  @override
  Future<bool> requestPermission(AppPermission permission) async {
    try {
      return await _channel.invokeMethod<bool>('requestPermission', {
            'name': permission.name,
          }) ??
          false;
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<void> openAppSettings() => _channel.invokeMethod('openAppSettings');

  @override
  Future<String?> alarmSoundName() =>
      _channel.invokeMethod<String>('alarmSound');

  @override
  Future<String?> pickAlarmSound() =>
      _channel.invokeMethod<String>('pickAlarmSound');

  @override
  Future<void> resetAlarmSound() => _channel.invokeMethod('resetAlarmSound');

  @override
  Future<void> previewAlarmSound({required bool play}) =>
      _channel.invokeMethod('previewAlarmSound', {'play': play});

  @override
  Future<void> stopAlarm() => _channel.invokeMethod('stopAlarm');

  @override
  Future<PickedContact?> pickContact() async {
    final result = await _channel.invokeMapMethod<String, String?>(
      'pickContact',
    );
    final phone = result?['phone'];
    if (phone == null || phone.trim().isEmpty) return null;
    return (name: result?['name'], phone: phone);
  }
}

/// Testlar va Android bo'lmagan platformalar.
class NoopNativeBridge implements NativeBridge {
  @override
  bool get supportsReminders => false;

  @override
  Future<void> syncReminders(List<Map<String, Object?>> reminders) async {}

  @override
  Future<bool> requestPermission(AppPermission permission) async => true;

  @override
  Future<void> openAppSettings() async {}

  @override
  Future<PickedContact?> pickContact() async => null;

  @override
  Future<String?> alarmSoundName() async => null;

  @override
  Future<String?> pickAlarmSound() async => null;

  @override
  Future<void> resetAlarmSound() async {}

  @override
  Future<void> previewAlarmSound({required bool play}) async {}

  @override
  Future<void> stopAlarm() async {}
}

@Riverpod(keepAlive: true)
NativeBridge nativeBridge(Ref ref) =>
    !kIsWeb && Platform.isAndroid ? AndroidNativeBridge() : NoopNativeBridge();
