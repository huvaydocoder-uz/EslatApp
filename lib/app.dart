import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'core/constants/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

class EslatApp extends ConsumerWidget {
  const EslatApp({super.key});

  static const _uzbek = Locale('uz');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(theme.seedColor),
      darkTheme: AppTheme.dark(theme.seedColor),
      themeMode: theme.themeMode,
      routerConfig: router,
      // Sana tanlagich, "Bekor qilish" kabi tizim matnlari o'zbekcha.
      locale: _uzbek,
      supportedLocales: const [_uzbek],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
