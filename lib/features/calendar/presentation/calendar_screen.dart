import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/section_header.dart';
import '../../events/data/events_repository.dart';
import '../../events/domain/event_occurrence.dart';
import '../../events/domain/important_event.dart';
import '../../events/presentation/calendar_controller.dart';
import '../../events/presentation/events_providers.dart';
import '../../events/presentation/widgets/event_card.dart';
import 'month_grid.dart';

/// Taqvim: oy jadvali (kunlar emoji bilan) va tanlangan kundagi kunlar.
class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calendarTitle),
        actions: [
          TextButton(
            onPressed: ref.read(calendarControllerProvider.notifier).goToday,
            child: Text(l10n.calendarGoToday),
          ),
        ],
      ),
      body: AsyncValueView<List<ImportantEvent>>(
        value: ref.watch(eventsProvider),
        onRetry: () => ref.invalidate(eventsProvider),
        // Planshetda jadval cho'zilib ketmasin.
        data: (events) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: _CalendarBody(events: events),
          ),
        ),
      ),
    );
  }
}

class _CalendarBody extends ConsumerWidget {
  const _CalendarBody({required this.events});

  final List<ImportantEvent> events;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final calendar = ref.watch(calendarControllerProvider);
    final today = ref.watch(todayProvider);
    final month = calendar.month;
    final byDay = EventDates.inMonth(events, month.year, month.month);
    final selected = calendar.selectedDay;
    final dayEvents =
        selected.month == month.month && selected.year == month.year
        ? byDay[selected.day] ?? const <ImportantEvent>[]
        : const <ImportantEvent>[];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      children: [
        MonthGrid(
          month: month,
          today: today,
          selectedDay: selected,
          eventsByDay: byDay,
        ),
        SectionHeader(
          MaterialLocalizations.of(context).formatFullDate(selected),
        ),
        if (dayEvents.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.calendarNoEventsDay,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          )
        else
          for (final event in dayEvents)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EventCard(occurrence: EventDates.occurrence(event, today)),
            ),
      ],
    );
  }
}
