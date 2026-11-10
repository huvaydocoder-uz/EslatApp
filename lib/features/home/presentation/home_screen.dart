import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/state_views.dart';
import '../../events/presentation/widgets/add_event_fab.dart';

/// Asosiy: bugungi va yaqinlashayotgan muhim kunlar.
/// 2-qadamda `AsyncValueView` + `upcomingEventsProvider` bilan to'ldiriladi.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.homeTitle)),
      body: const EmptyView(
        icon: Icons.celebration_outlined,
        title: AppStrings.homeEmptyTitle,
        message: AppStrings.homeEmptyMessage,
      ),
      floatingActionButton: const AddEventFab(),
    );
  }
}
