import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/card_section.dart';
import '../../auth/data/auth_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/domain/user_profile.dart';
import '../../subscription/domain/plan.dart';
import '../data/app_preferences.dart';
import 'settings_controller.dart';
import 'widgets/account_card.dart';
import 'widgets/color_palette_selector.dart';
import 'widgets/custom_types_section.dart';
import 'widgets/language_selector.dart';
import 'widgets/sign_out_button.dart';
import 'widgets/theme_mode_selector.dart';

/// Sozlamalar: hisob, til, kunduzgi/tungi rejim, asosiy rang, chiqish.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(settingsControllerProvider, (_, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(context.l10n.settingsSaveError)),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settingsTitle)),
      body: AsyncValueView<UserProfile?>(
        value: ref.watch(currentProfileProvider),
        onRetry: () => ref.invalidate(currentProfileProvider),
        // Profil hali yaratilmagan bo'lsa ham sozlamalar standart qiymatlar
        // bilan ishlaydi — birinchi saqlashda profil yaratiladi.
        data: (profile) => _SettingsList(plan: profile?.plan ?? AppPlan.free),
      ),
    );
  }
}

class _SettingsList extends ConsumerWidget {
  const _SettingsList({required this.plan});

  final AppPlan plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(authStateProvider).value;
    final theme = ref.watch(themeSettingsProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final language = ref.watch(appLanguageProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        if (user != null) AccountCard(user: user, plan: plan),
        CardSection(
          title: l10n.settingsLanguage,
          child: LanguageSelector(
            selected: language,
            onSelected: controller.setLanguage,
          ),
        ),
        CardSection(
          title: l10n.settingsTheme,
          child: ThemeModeSelector(
            selected: theme.themeMode,
            onSelected: controller.setThemeMode,
          ),
        ),
        CardSection(
          title: l10n.settingsColor,
          child: ColorPaletteSelector(
            selected: theme.seedColor,
            onSelected: controller.setSeedColor,
          ),
        ),
        CardSection(
          title: l10n.settingsCustomTypes,
          child: const CustomTypesSection(),
        ),
        const SizedBox(height: 32),
        const SignOutButton(),
      ],
    );
  }
}
