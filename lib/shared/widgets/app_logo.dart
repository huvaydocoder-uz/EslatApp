import 'package:material_ui/material_ui.dart';

import '../../core/constants/app_strings.dart';

/// Eslat logotipi: yumaloq kvadrat ichida qo'ng'iroqcha (bell).
///
/// Ranglari joriy mavzudan olinadi — foydalanuvchi rangni o'zgartirsa,
/// logo ham moslashadi. Ilova ikonkasi uchun vektor manba:
/// `assets/branding/eslat_logo.svg`.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: AppStrings.appName,
      image: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [scheme.primary, scheme.primary.withValues(alpha: 0.78)],
          ),
        ),
        child: Icon(
          Icons.notifications_active_rounded,
          size: size * 0.58,
          color: scheme.onPrimary,
        ),
      ),
    );
  }
}
