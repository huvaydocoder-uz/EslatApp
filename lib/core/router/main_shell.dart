import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../constants/app_strings.dart';

/// Pastki menyuli asosiy karkas: 4 ta bo'lim, katta ikonka va yozuvlar.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    (Icons.home_outlined, Icons.home_rounded, AppStrings.navHome),
    (
      Icons.celebration_outlined,
      Icons.celebration_rounded,
      AppStrings.navEvents,
    ),
    (
      Icons.calendar_month_outlined,
      Icons.calendar_month_rounded,
      AppStrings.navCalendar,
    ),
    (Icons.settings_outlined, Icons.settings_rounded, AppStrings.navSettings),
  ];

  void _onSelect(int index) {
    // Faol bo'limni qayta bossa — o'sha bo'limning bosh sahifasiga qaytadi.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onSelect,
        destinations: [
          for (final (icon, selectedIcon, label) in _destinations)
            NavigationDestination(
              icon: Icon(icon),
              selectedIcon: Icon(selectedIcon),
              label: label,
              tooltip: label,
            ),
        ],
      ),
    );
  }
}
