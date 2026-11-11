import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'events_providers.dart';

part 'calendar_controller.g.dart';

typedef CalendarState = ({DateTime month, DateTime selectedDay});

/// Taqvim: ko'rsatilayotgan oy va tanlangan kun.
@Riverpod(keepAlive: true)
class CalendarController extends _$CalendarController {
  @override
  CalendarState build() {
    final today = ref.read(todayProvider);
    return (month: DateTime(today.year, today.month), selectedDay: today);
  }

  void previousMonth() => _showMonth(-1);
  void nextMonth() => _showMonth(1);

  void goToday() {
    final today = ref.read(todayProvider);
    state = (month: DateTime(today.year, today.month), selectedDay: today);
  }

  void select(DateTime day) => state = (month: state.month, selectedDay: day);

  void _showMonth(int delta) {
    final month = DateTime(state.month.year, state.month.month + delta);
    state = (month: month, selectedDay: month);
  }
}
