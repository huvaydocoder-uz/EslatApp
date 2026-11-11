import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../data/categories_repository.dart';
import '../../domain/custom_category.dart';
import '../../domain/event_category.dart';
import '../categories_controller.dart';
import '../event_category_ui.dart';
import '../event_type.dart';
import '../widgets/emoji_picker_sheet.dart';
import '../widgets/new_type_dialog.dart';
import 'event_form_controller.dart';

/// Katta emoji tugmasi va tur tanlovi: tayyor turlar, o'z turlari, "Yangi tur".
class EmojiCategorySection extends ConsumerWidget {
  const EmojiCategorySection({super.key, required this.eventId});

  final String? eventId;

  Future<void> _pickEmoji(BuildContext context, WidgetRef ref) async {
    final emoji = await showEmojiPicker(context);
    if (emoji != null) {
      ref.read(eventFormControllerProvider(eventId).notifier).setEmoji(emoji);
    }
  }

  Future<void> _newType(BuildContext context, WidgetRef ref) async {
    final type = await showNewTypeDialog(context);
    if (type == null) return;
    final id = await ref
        .read(categoriesControllerProvider.notifier)
        .create(type.name, type.emoji);
    if (id == null) return;
    // Ro'yxat yangilanishini kutmasdan darhol tanlanadi.
    ref
        .read(eventFormControllerProvider(eventId).notifier)
        .setCustomCategory(
          CustomCategory(id: id, name: type.name, emoji: type.emoji),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final draft = ref.watch(eventFormControllerProvider(eventId)).draft;
    final form = ref.read(eventFormControllerProvider(eventId).notifier);
    final customs = ref.watch(customCategoriesProvider).value ?? const [];
    final selected = EventType.of(draft, customs);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Semantics(
            button: true,
            label: l10n.formChooseEmoji,
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => _pickEmoji(context, ref),
              child: Ink(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child: Text(
                    draft.emoji,
                    style: const TextStyle(fontSize: 52),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            for (final category in EventCategory.values)
              ChoiceChip(
                avatar: Icon(category.icon, size: 20),
                label: Text(category.label(l10n)),
                selected: selected == EventType.builtIn(category),
                onSelected: (_) => form.setCategory(category),
              ),
            for (final custom in customs)
              ChoiceChip(
                avatar: Text(custom.emoji),
                label: Text(custom.name),
                selected: selected == EventType.custom(custom),
                onSelected: (_) => form.setCustomCategory(custom),
              ),
            ActionChip(
              avatar: const Icon(Icons.add_rounded, size: 20),
              label: Text(l10n.formNewType),
              onPressed: () => _newType(context, ref),
            ),
          ],
        ),
      ],
    );
  }
}
