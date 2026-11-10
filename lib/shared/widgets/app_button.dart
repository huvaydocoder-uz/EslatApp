import 'package:material_ui/material_ui.dart';

enum AppButtonVariant { filled, tonal, outlined }

/// Ilovadagi yagona katta tugma (balandligi 56dp, ikonka + matn).
///
/// [isLoading] bo'lsa tugma bosilmaydi va aylanuvchi indikator ko'rsatiladi —
/// ikki marta bosib ikki marta so'rov yuborishning oldi olinadi.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.filled,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final onTap = isLoading ? null : onPressed;
    final Widget child = isLoading
        ? const SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          )
        : Text(label);
    final iconWidget = icon == null || isLoading ? null : Icon(icon, size: 26);

    final button = switch ((variant, iconWidget)) {
      (AppButtonVariant.filled, null) => FilledButton(
        onPressed: onTap,
        child: child,
      ),
      (AppButtonVariant.filled, final i?) => FilledButton.icon(
        onPressed: onTap,
        icon: i,
        label: child,
      ),
      (AppButtonVariant.tonal, null) => FilledButton.tonal(
        onPressed: onTap,
        child: child,
      ),
      (AppButtonVariant.tonal, final i?) => FilledButton.tonalIcon(
        onPressed: onTap,
        icon: i,
        label: child,
      ),
      (AppButtonVariant.outlined, null) => OutlinedButton(
        onPressed: onTap,
        child: child,
      ),
      (AppButtonVariant.outlined, final i?) => OutlinedButton.icon(
        onPressed: onTap,
        icon: i,
        label: child,
      ),
    };

    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: button,
    );
  }
}
