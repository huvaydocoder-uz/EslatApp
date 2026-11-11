import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';

/// SMS ruxsati berilmaganda: nima qilishni qadamma-qadam ko'rsatadi.
///
/// Android 13+ da APK'dan o'rnatilgan ilovalar uchun SMS — "cheklangan
/// sozlama": ruxsat oynasi chiqmaydi, faqat telefon sozlamalaridan yoqiladi.
Future<void> showSmsPermissionDialog(
  BuildContext context, {
  required Future<void> Function() onOpenSettings,
}) {
  final l10n = context.l10n;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.sms_failed_rounded, size: 40),
      title: Text(l10n.smsPermissionTitle),
      content: SingleChildScrollView(
        child: Text(
          l10n.smsPermissionSteps,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton.icon(
          icon: const Icon(Icons.settings_rounded),
          label: Text(l10n.openSettings),
          onPressed: () {
            Navigator.of(context).pop();
            onOpenSettings();
          },
        ),
      ],
    ),
  );
}
