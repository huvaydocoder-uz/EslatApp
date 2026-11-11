import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/state_views.dart';
import '../data/categories_repository.dart';
import '../domain/event_category.dart';
import '../domain/event_occurrence.dart';
import 'event_category_ui.dart';
import 'event_type.dart';
import 'events_providers.dart';
import 'widgets/add_event_fab.dart';
import 'widgets/event_card.dart';

/// Kunlar: barcha muhim kunlar (yaqinidan boshlab), toifa bo'yicha filtr.
class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.watch(eventsFilterProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.eventsTitle)),
      floatingActionButton: const AddEventFab(),
      body: Column(
        children: [
          _FilterBar(selected: filter),
          Expanded(
            child: AsyncValueView<List<EventOccurrence>>(
              value: ref
                  .watch(eventOccurrencesProvider)
                  .whenData(
                    (all) => filter == null
                        ? all
                        : all.where((o) => filter.matches(o.event)).toList(),
                  ),
              onRetry: () => ref.invalidate(eventOccurrencesProvider),
              isEmpty: (list) => list.isEmpty,
              empty: EmptyView(
                icon: Icons.event_note_outlined,
                title: l10n.eventsEmptyTitle,
                message: l10n.eventsEmptyMessage,
              ),
              data: (list) => ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 112),
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, i) => EventCard(occurrence: list[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends ConsumerWidget {
  const _FilterBar({required this.selected});

  final EventType? selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.read(eventsFilterProvider.notifier);
    final customs = ref.watch(customCategoriesProvider).value ?? const [];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        spacing: 8,
        children: [
          ChoiceChip(
            label: Text(l10n.filterAll),
            selected: selected == null,
            onSelected: (_) => filter.select(null),
          ),
          for (final category in EventCategory.values)
            ChoiceChip(
              avatar: Text(category.defaultEmoji),
              label: Text(category.label(l10n)),
              selected: selected == EventType.builtIn(category),
              onSelected: (_) => filter.select(EventType.builtIn(category)),
            ),
          for (final custom in customs)
            ChoiceChip(
              avatar: Text(custom.emoji),
              label: Text(custom.name),
              selected: selected == EventType.custom(custom),
              onSelected: (_) => filter.select(EventType.custom(custom)),
            ),
        ],
      ),
    );
  }
}
