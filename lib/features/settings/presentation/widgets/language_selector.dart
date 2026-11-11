import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/app_language.dart';

/// 3 ta til — katta qatorlar, tanlangani belgi bilan.
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final AppLanguage selected;
  final ValueChanged<AppLanguage> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        for (final language in AppLanguage.values)
          ListTile(
            leading: const Icon(Icons.language_rounded),
            title: Text(language.nativeName),
            selected: language == selected,
            trailing: language == selected
                ? Icon(Icons.check_circle_rounded, color: scheme.primary)
                : null,
            onTap: () => onSelected(language),
          ),
      ],
    );
  }
}
