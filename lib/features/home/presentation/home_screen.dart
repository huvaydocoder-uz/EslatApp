import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/state_views.dart';
import '../../events/presentation/widgets/add_event_fab.dart';

/// Asosiy: bugungi va yaqinlashayotgan muhim kunlar.
/// 2-qadamda `AsyncValueView` + `upcomingEventsProvider` bilan to'ldiriladi.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeTitle)),
      body: EmptyView(
        icon: Icons.celebration_outlined,
        title: l10n.homeEmptyTitle,
        message: l10n.homeEmptyMessage,
      ),
      floatingActionButton: const AddEventFab(),
    );
  }
}
