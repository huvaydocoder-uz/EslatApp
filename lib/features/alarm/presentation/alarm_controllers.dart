import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/platform/native_bridge.dart';

part 'alarm_controllers.g.dart';

/// Budilnik musiqasi (telefon xotirasidan). `null` — standart budilnik ovozi.
/// Faqat shu telefonda saqlanadi: fayl boshqa telefonda bo'lmaydi.
@Riverpod(keepAlive: true)
class AlarmSoundController extends _$AlarmSoundController {
  @override
  Future<String?> build() => ref.watch(nativeBridgeProvider).alarmSoundName();

  Future<void> pick() async {
    final name = await ref.read(nativeBridgeProvider).pickAlarmSound();
    if (name != null && ref.mounted) state = AsyncData(name);
  }

  Future<void> reset() async {
    await ref.read(nativeBridgeProvider).resetAlarmSound();
    if (ref.mounted) state = const AsyncData(null);
  }
}

/// "Tinglab ko'rish": 10 soniya chaladi yoki qo'lda to'xtatiladi.
@riverpod
class AlarmPreview extends _$AlarmPreview {
  Timer? _timer;
  var _playing = false;

  @override
  bool build() {
    // Yopilishda Ref ishlatib bo'lmaydi — ko'prik oldindan olinadi.
    final bridge = ref.watch(nativeBridgeProvider);
    ref.onDispose(() {
      _timer?.cancel();
      if (_playing) unawaited(bridge.previewAlarmSound(play: false));
    });
    return false;
  }

  Future<void> toggle() async {
    final play = !state;
    _playing = play;
    state = play;
    _timer?.cancel();
    if (play) {
      _timer = Timer(const Duration(seconds: 10), () {
        _playing = false;
        if (ref.mounted) state = false;
      });
    }
    await ref.read(nativeBridgeProvider).previewAlarmSound(play: play);
  }
}

/// Chalayotgan budilnikni to'xtatish (budilnik ekranidan).
@riverpod
class AlarmController extends _$AlarmController {
  @override
  FutureOr<void> build() {}

  Future<void> stop() => ref.read(nativeBridgeProvider).stopAlarm();
}
