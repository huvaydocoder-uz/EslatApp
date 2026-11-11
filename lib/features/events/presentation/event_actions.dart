import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/data/auth_repository.dart';
import '../data/events_repository.dart';

part 'event_actions.g.dart';

/// Muhim kun ustidagi amallar (hozircha: o'chirish).
@riverpod
class EventActions extends _$EventActions {
  @override
  FutureOr<void> build() {}

  /// Muvaffaqiyatli bo'lsa `true`.
  Future<bool> delete(String eventId) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return false;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(eventsRepositoryProvider).delete(user.uid, eventId),
    );
    if (ref.mounted) state = result;
    return !result.hasError;
  }
}
