import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_routes.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_logo.dart';

/// Kirish usulini tanlash: Gmail, telefon (SMS kod), Telegram.
///
/// 1-qadamda faqat ko'rinish va navigatsiya. Kirish mantiqi 2-qadamda
/// `AuthController` (Riverpod) ichida yoziladi.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text(AppStrings.comingSoon)));
  }

  @override
  Widget build(BuildContext context) {
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
                  const Center(child: AppLogo(size: 112)),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.loginTitle,
                    style: text.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.loginSubtitle,
                    style: text.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                    icon: Icons.mail_rounded,
                    label: AppStrings.loginWithGoogle,
                    onPressed: () => _showComingSoon(context),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    variant: AppButtonVariant.tonal,
                    icon: Icons.phone_rounded,
                    label: AppStrings.loginWithPhone,
                    onPressed: () => context.push(AppRoutes.authPhone),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    variant: AppButtonVariant.outlined,
                    icon: Icons.send_rounded,
                    label: AppStrings.loginWithTelegram,
                    onPressed: () => context.push(AppRoutes.authTelegram),
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
