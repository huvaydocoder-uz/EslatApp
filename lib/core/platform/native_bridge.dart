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
}

@Riverpod(keepAlive: true)
NativeBridge nativeBridge(Ref ref) =>
    !kIsWeb && Platform.isAndroid ? AndroidNativeBridge() : NoopNativeBridge();
