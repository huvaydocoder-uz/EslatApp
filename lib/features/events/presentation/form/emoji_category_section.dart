import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/event_category.dart';
import '../event_category_ui.dart';
import 'event_form_controller.dart';

/// Katta emoji tugmasi (bosilsa — tanlash oynasi) va toifa tanlovi.
class EmojiCategorySection extends ConsumerWidget {
  const EmojiCategorySection({super.key, required this.eventId});

  final String? eventId;

  Future<void> _pickEmoji(BuildContext context, WidgetRef ref) async {
    final emoji = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => _EmojiGrid(title: context.l10n.formChooseEmoji),
    );
    if (emoji != null) {
      ref.read(eventFormControllerProvider(eventId).notifier).setEmoji(emoji);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final draft = ref.watch(eventFormControllerProvider(eventId)).draft;
    final form = ref.read(eventFormControllerProvider(eventId).notifier);
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
                selected: draft.category == category,
                onSelected: (_) => form.setCategory(category),
              ),
          ],
        ),
      ],
    );
  }
}

class _EmojiGrid extends StatelessWidget {
  const _EmojiGrid({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Flexible(
            child: GridView.extent(
              shrinkWrap: true,
              maxCrossAxisExtent: 64,
              padding: const EdgeInsets.all(16),
              children: [
                for (final emoji in eventEmojis)
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).pop(emoji),
                    child: Center(
                      child: Text(emoji, style: const TextStyle(fontSize: 34)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
