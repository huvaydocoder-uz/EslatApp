import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/state_views.dart';

/// Taqvim: oylik ko'rinish, muhim kunlar emoji bilan belgilanadi.
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.calendarTitle)),
      body: EmptyView(
        icon: Icons.calendar_month_outlined,
        title: l10n.calendarEmptyTitle,
        message: l10n.calendarEmptyMessage,
      ),
    );
  }
}
