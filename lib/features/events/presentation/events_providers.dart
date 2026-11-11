import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/events_repository.dart';
import '../domain/event_occurrence.dart';
import 'event_type.dart';

part 'events_providers.g.dart';

/// Bugungi sana (soatsiz). Testlarda almashtiriladi.
@riverpod
DateTime today(Ref ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

/// Barcha muhim kunlar keyingi sanasi bo'yicha saralangan holda.
@riverpod
AsyncValue<List<EventOccurrence>> eventOccurrences(Ref ref) {
  final today = ref.watch(todayProvider);
  return ref
      .watch(eventsProvider)
      .whenData((events) => EventDates.sorted(events, today));
}

/// "Kunlar" ekranidagi tur filtri (tayyor yoki o'z turi). `null` — hammasi.
@riverpod
class EventsFilter extends _$EventsFilter {
  @override
  EventType? build() => null;

  void select(EventType? type) => state = type;
}

/// Bitta muhim kun (tafsilotlar ekrani uchun). Topilmasa — `null`.
@riverpod
AsyncValue<EventOccurrence?> eventOccurrence(Ref ref, String eventId) {
  return ref
      .watch(eventOccurrencesProvider)
      .whenData((all) => all.where((o) => o.event.id == eventId).firstOrNull);
}
