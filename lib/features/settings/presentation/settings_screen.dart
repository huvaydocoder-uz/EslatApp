import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/state_views.dart';

/// Sozlamalar: mavzu (kunduzgi/tungi), rang, ovoz, til, hisob, Pro.
/// Mavzu mantiqi tayyor: `themeControllerProvider` (core/theme).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTitle)),
      body: const EmptyView(
        icon: Icons.tune_rounded,
        title: AppStrings.settingsEmptyTitle,
        message: AppStrings.settingsEmptyMessage,
      ),
    );
  }
}
