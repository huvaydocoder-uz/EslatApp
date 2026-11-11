import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../settings/presentation/widgets/language_chips.dart';
import '../domain/auth_failure.dart';
import 'auth_controller.dart';

/// Kirish: bitta katta tugma — "Gmail orqali kirish". Ro'yxatdan o'tish
/// bepul, kod kiritilmaydi. Mantiq `AuthController` da.
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static String errorMessage(AppLocalizations l10n, Object? error) {
    return switch (error) {
      AuthFailure(reason: AuthFailureReason.network) => l10n.authErrorNetwork,
      AuthFailure(reason: AuthFailureReason.notConfigured) =>
        l10n.authErrorNotConfigured,
      _ => l10n.authErrorUnknown,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (_, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(errorMessage(context.l10n, next.error))),
          );
      }
    });
    final isLoading = ref.watch(authControllerProvider).isLoading;
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LanguageChips(),
                  const SizedBox(height: 32),
                  const Center(child: AppLogo(size: 112)),
                  const SizedBox(height: 24),
                  Text(
                    l10n.loginTitle,
                    style: text.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.loginSubtitle,
                    style: text.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                    icon: Icons.mail_rounded,
                    label: l10n.loginWithGoogle,
                    isLoading: isLoading,
                    onPressed: () => ref
                        .read(authControllerProvider.notifier)
                        .signInWithGoogle(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.loginAutoNote,
                    style: text.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
