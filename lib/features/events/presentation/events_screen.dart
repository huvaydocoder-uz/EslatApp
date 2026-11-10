import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/state_views.dart';
import 'widgets/add_event_fab.dart';

/// Kunlar: barcha muhim kunlar ro'yxati (toifa bo'yicha filtr, qidiruv).
/// 2-qadamda `AsyncValueView` + `eventsProvider` bilan to'ldiriladi.
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.eventsTitle)),
      body: const EmptyView(
        icon: Icons.event_note_outlined,
        title: AppStrings.eventsEmptyTitle,
        message: AppStrings.eventsEmptyMessage,
      ),
      floatingActionButton: const AddEventFab(),
    );
  }
}
