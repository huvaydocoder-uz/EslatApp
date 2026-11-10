import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/state_views.dart';

/// Taqvim: oylik ko'rinish, muhim kunlar emoji bilan belgilanadi.
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.calendarTitle)),
      body: const EmptyView(
        icon: Icons.calendar_month_outlined,
        title: AppStrings.calendarEmptyTitle,
        message: AppStrings.calendarEmptyMessage,
      ),
    );
  }
}
