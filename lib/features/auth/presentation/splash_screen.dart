import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/state_views.dart';

/// Ilova ochilganda Firebase kirish holatini aniqlaguncha ko'rinadi.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(size: 120),
            const SizedBox(height: 24),
            Text(
              context.l10n.appName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            const LoadingView(),
          ],
        ),
      ),
    );
  }
}
