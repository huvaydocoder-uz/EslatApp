import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../events/data/categories_repository.dart';
import '../../../events/domain/custom_category.dart';
import '../../../events/presentation/categories_controller.dart';
import '../../../events/presentation/widgets/new_type_dialog.dart';

/// "Mening turlarim": o'z muhim kun turlarini qo'shish va o'chirish.
class CustomTypesSection extends ConsumerWidget {
  const CustomTypesSection({super.key});

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final type = await showNewTypeDialog(context);
    if (type == null) return;
    await ref
        .read(categoriesControllerProvider.notifier)
        .create(type.name, type.emoji);
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    CustomCategory custom,
  ) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteTypeConfirmTitle),
        content: Text(l10n.deleteTypeConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(categoriesControllerProvider.notifier).delete(custom.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final customs = ref.watch(customCategoriesProvider).value ?? const [];
    return Column(
      children: [
        if (customs.isEmpty) ListTile(title: Text(l10n.customTypesEmpty)),
        for (final custom in customs)
          ListTile(
            leading: Text(custom.emoji, style: const TextStyle(fontSize: 28)),
            title: Text(custom.name),
            trailing: IconButton(
              tooltip: l10n.deleteAction,
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => _delete(context, ref, custom),
            ),
          ),
        ListTile(
          leading: const Icon(Icons.add_rounded),
          title: Text(l10n.formNewType),
          onTap: () => _add(context, ref),
        ),
      ],
    );
  }
}
