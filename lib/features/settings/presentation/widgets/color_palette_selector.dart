import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_palette.dart';

/// 12 ta katta rang doirachasi (52dp). Tanlangani — belgi va hoshiya bilan.
class ColorPaletteSelector extends StatelessWidget {
  const ColorPaletteSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final Color selected;
  final ValueChanged<Color> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final outline = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        alignment: WrapAlignment.center,
        children: [
          for (final palette in AppPalette.colors)
            _ColorDot(
              color: palette.color,
              label: palette.label(l10n),
              isSelected: palette.color.toARGB32() == selected.toARGB32(),
              outline: outline,
              onTap: () => onSelected(palette.color),
            ),
        ],
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({
    required this.color,
    required this.label,
    required this.isSelected,
    required this.outline,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool isSelected;
  final Color outline;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Tooltip(
        message: label,
        child: InkResponse(
          onTap: onTap,
          radius: 32,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? outline : Colors.transparent,
                width: 3,
              ),
            ),
            child: isSelected
                ? Icon(Icons.check_rounded, color: onColor, size: 28)
                : null,
          ),
        ),
      ),
    );
  }
}
