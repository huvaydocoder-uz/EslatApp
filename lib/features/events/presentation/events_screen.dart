import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/state_views.dart';
import 'widgets/add_event_fab.dart';

/// Kunlar: barcha muhim kunlar ro'yxati (toifa bo'yicha filtr, qidiruv).
/// 2-qadamda `AsyncValueView` + `eventsProvider` bilan to'ldiriladi.
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.eventsTitle)),
      body: EmptyView(
        icon: Icons.event_note_outlined,
        title: l10n.eventsEmptyTitle,
        message: l10n.eventsEmptyMessage,
      ),
      floatingActionButton: const AddEventFab(),
    );
  }
}
