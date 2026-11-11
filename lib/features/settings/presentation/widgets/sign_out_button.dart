import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../auth/presentation/auth_controller.dart';

/// "Hisobdan chiqish" — tasodifan bosilmasligi uchun tasdiq so'raladi.
class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  Future<void> _confirm(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.signOutConfirmTitle),
        content: Text(l10n.signOutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.signOut),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(authControllerProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton(
      variant: AppButtonVariant.outlined,
      icon: Icons.logout_rounded,
      label: context.l10n.signOut,
      isLoading: ref.watch(authControllerProvider).isLoading,
      onPressed: () => _confirm(context, ref),
    );
  }
}
