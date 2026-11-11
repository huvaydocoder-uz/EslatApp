import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../../events/domain/event_occurrence.dart';
import '../../events/presentation/events_providers.dart';
import '../../events/presentation/widgets/add_event_fab.dart';
import '../../events/presentation/widgets/event_card.dart';

/// Asosiy: bugungi muhim kunlar (ajratilgan) va yaqin 30 kun.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const upcomingDays = 30;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeTitle)),
      floatingActionButton: const AddEventFab(),
      body: AsyncValueView<List<EventOccurrence>>(
        value: ref.watch(eventOccurrencesProvider),
        onRetry: () => ref.invalidate(eventOccurrencesProvider),
        isEmpty: (all) => all.isEmpty,
        empty: EmptyView(
          icon: Icons.celebration_outlined,
          title: l10n.homeEmptyTitle,
          message: l10n.homeEmptyMessage,
        ),
        data: (all) => _HomeList(occurrences: all),
      ),
    );
  }
}

class _HomeList extends StatelessWidget {
  const _HomeList({required this.occurrences});

  final List<EventOccurrence> occurrences;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final today = occurrences.where((o) => o.isToday).toList();
    final soon = occurrences
        .where((o) => o.daysUntil > 0 && o.daysUntil <= HomeScreen.upcomingDays)
        .toList();

    if (today.isEmpty && soon.isEmpty) {
      return EmptyView(
        icon: Icons.event_available_rounded,
        title: l10n.homeNothingSoonTitle,
        message: l10n.homeNothingSoonMessage,
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 112),
      children: [
        if (today.isNotEmpty) ...[
          SectionHeader(l10n.homeTitle),
          for (final o in today) _spaced(EventCard(occurrence: o)),
        ],
        if (soon.isNotEmpty) ...[
          SectionHeader(l10n.homeUpcomingSection),
          for (final o in soon) _spaced(EventCard(occurrence: o)),
        ],
      ],
    );
  }

  static Widget _spaced(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 12), child: child);
}
