import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';

/// Tizim / Kunduzgi / Tungi rejim.
class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ThemeMode selected;
  final ValueChanged<ThemeMode> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SegmentedButton<ThemeMode>(
        showSelectedIcon: false,
        selected: {selected},
        onSelectionChanged: (modes) => onSelected(modes.first),
        segments: [
          ButtonSegment(
            value: ThemeMode.system,
            icon: const Icon(Icons.brightness_auto_rounded),
            label: Text(l10n.themeModeSystem),
          ),
          ButtonSegment(
            value: ThemeMode.light,
            icon: const Icon(Icons.light_mode_rounded),
            label: Text(l10n.themeModeLight),
          ),
          ButtonSegment(
            value: ThemeMode.dark,
            icon: const Icon(Icons.dark_mode_rounded),
            label: Text(l10n.themeModeDark),
          ),
        ],
      ),
    );
  }
}
