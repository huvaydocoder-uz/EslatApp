import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../firebase/firebase_providers.dart';
import '../l10n/l10n.dart';

/// Pastki menyuli asosiy karkas: 4 ta bo'lim, katta ikonka va yozuvlar.
class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static List<(IconData, IconData, String)> _destinations(
    AppLocalizations l10n,
  ) => [
    (Icons.home_outlined, Icons.home_rounded, l10n.navHome),
    (Icons.celebration_outlined, Icons.celebration_rounded, l10n.navEvents),
    (
      Icons.calendar_month_outlined,
      Icons.calendar_month_rounded,
      l10n.navCalendar,
    ),
    (Icons.settings_outlined, Icons.settings_rounded, l10n.navSettings),
  ];

  void _onSelect(int index) {
    // Faol bo'limni qayta bossa — o'sha bo'limning bosh sahifasiga qaytadi.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demo = !ref.watch(firebaseReadyProvider);
    return Scaffold(
      body: demo
          ? Column(
              children: [
                const _DemoBanner(),
                Expanded(child: navigationShell),
              ],
            )
          : navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onSelect,
        destinations: [
          for (final (icon, selectedIcon, label) in _destinations(context.l10n))
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

/// Sinov rejimi ogohlantirishi: ma'lumot faqat ilova yopilguncha turadi.
class _DemoBanner extends StatelessWidget {
  const _DemoBanner();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.tertiaryContainer,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Icon(Icons.science_rounded, color: scheme.onTertiaryContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  context.l10n.demoBanner,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: scheme.onTertiaryContainer),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
