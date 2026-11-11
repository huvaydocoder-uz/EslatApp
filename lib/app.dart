import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'core/l10n/app_language.dart';
import 'core/l10n/l10n.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/data/app_preferences.dart';

class EslatApp extends ConsumerWidget {
  const EslatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeSettingsProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(theme.seedColor),
      darkTheme: AppTheme.dark(theme.seedColor),
      themeMode: theme.themeMode,
      routerConfig: router,
      // 3 til: o'zbek, rus, ingliz. Foydalanuvchi tanlamagan bo'lsa —
      // telefon tili; u ham mos kelmasa — ingliz tili.
      locale: ref.watch(appLocaleProvider),
      supportedLocales: AppLanguage.supportedLocales,
      localeListResolutionCallback: (deviceLocales, _) =>
          AppLanguage.fromDevice(deviceLocales).locale,
      // Tizim matnlari (sana tanlagich, "Bekor qilish") material_ui dan.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
    );
  }
}
