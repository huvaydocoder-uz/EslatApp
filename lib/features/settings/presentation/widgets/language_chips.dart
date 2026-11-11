import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/app_language.dart';
import '../../data/app_preferences.dart';

/// Kirish ekranidagi til tanlash: 🇺🇿 O'zbekcha · 🇷🇺 Русский · 🇬🇧 English.
/// Tanlov kirgandan keyin profilga saqlanadi.
class LanguageChips extends ConsumerWidget {
  const LanguageChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(appLanguageProvider);
    final choice = ref.read(languageChoiceProvider.notifier);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        for (final language in AppLanguage.values)
          ChoiceChip(
            avatar: Text(language.flag, style: const TextStyle(fontSize: 18)),
            label: Text(language.nativeName),
            selected: language == current,
            showCheckmark: false,
            onSelected: (_) => choice.choose(language),
          ),
      ],
    );
  }
}
