import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import 'emoji_picker_sheet.dart';

typedef NewType = ({String name, String emoji});

/// "Yangi muhim kun turi": nomi + emoji. Bekor qilinsa — `null`.
Future<NewType?> showNewTypeDialog(BuildContext context) => showDialog<NewType>(
  context: context,
  builder: (_) => const _NewTypeDialog(),
);

class _NewTypeDialog extends StatefulWidget {
  const _NewTypeDialog();

  @override
  State<_NewTypeDialog> createState() => _NewTypeDialogState();
}

class _NewTypeDialogState extends State<_NewTypeDialog> {
  final _name = TextEditingController();
  var _emoji = '⭐';
  var _submitted = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _chooseEmoji() async {
    final emoji = await showEmojiPicker(context);
    if (emoji != null && mounted) setState(() => _emoji = emoji);
  }

  void _create() {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _submitted = true);
      return;
    }
    Navigator.of(context).pop((name: name, emoji: _emoji));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.newTypeTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            button: true,
            label: l10n.formChooseEmoji,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: _chooseEmoji,
              child: Ink(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(_emoji, style: const TextStyle(fontSize: 44)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _name,
            autofocus: true,
            maxLength: 40,
            textCapitalization: TextCapitalization.sentences,
            onSubmitted: (_) => _create(),
            decoration: InputDecoration(
              labelText: l10n.newTypeName,
              hintText: l10n.newTypeNameHint,
              counterText: '',
              errorText: _submitted && _name.text.trim().isEmpty
                  ? l10n.formErrorRequired
                  : null,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(onPressed: _create, child: Text(l10n.createAction)),
      ],
    );
  }
}
