import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/event_category.dart';
import 'emoji_input.dart';

/// Emoji tanlash: 40 ta tayyor + klaviaturadan istalgani. Bekor — `null`.
Future<String?> showEmojiPicker(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => const _EmojiPickerSheet(),
  );
}

class _EmojiPickerSheet extends StatefulWidget {
  const _EmojiPickerSheet();

  @override
  State<_EmojiPickerSheet> createState() => _EmojiPickerSheetState();
}

class _EmojiPickerSheetState extends State<_EmojiPickerSheet> {
  final _other = TextEditingController();
  var _invalid = false;

  @override
  void dispose() {
    _other.dispose();
    super.dispose();
  }

  void _submitOther() {
    final emoji = singleEmoji(_other.text);
    if (emoji == null) {
      setState(() => _invalid = true);
    } else {
      Navigator.of(context).pop(emoji);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.formChooseEmoji,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GridView.extent(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                maxCrossAxisExtent: 64,
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  for (final emoji in eventEmojis)
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => Navigator.of(context).pop(emoji),
                      child: Center(
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 34),
                        ),
                      ),
                    ),
                ],
              ),
              TextField(
                controller: _other,
                style: const TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
                onSubmitted: (_) => _submitOther(),
                decoration: InputDecoration(
                  labelText: l10n.emojiOtherLabel,
                  errorText: _invalid ? l10n.emojiOtherInvalid : null,
                  suffixIcon: IconButton(
                    tooltip: l10n.done,
                    icon: const Icon(Icons.check_rounded),
                    onPressed: _submitOther,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
