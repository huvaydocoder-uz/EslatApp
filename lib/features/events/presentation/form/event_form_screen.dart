import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/card_section.dart';
import 'date_section.dart';
import 'emoji_category_section.dart';
import 'event_form_controller.dart';
import 'reminder_section.dart';
import 'sms_permission_dialog.dart';
import 'text_sections.dart';

/// Muhim kun qo'shish ([eventId] `null`) yoki tahrirlash.
class EventFormScreen extends ConsumerWidget {
  const EventFormScreen({super.key, this.eventId});

  final String? eventId;

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final saved = await ref
        .read(eventFormControllerProvider(eventId).notifier)
        .save();
    if (saved && context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(eventFormControllerProvider(eventId));
    ref.listen(eventFormControllerProvider(eventId), (previous, next) {
      void show(String message) => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
      if (next.saveFailed && !(previous?.saveFailed ?? false)) {
        show(l10n.saveError);
      }
      if (next.smsPermissionDenied &&
          !(previous?.smsPermissionDenied ?? false)) {
        showSmsPermissionDialog(
          context,
          onOpenSettings: ref
              .read(eventFormControllerProvider(eventId).notifier)
              .openAppSettings,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(state.isEditing ? l10n.editEventTitle : l10n.addEventTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          EmojiCategorySection(eventId: eventId),
          const SizedBox(height: 24),
          BasicsSection(eventId: eventId),
          CardSection(
            title: l10n.formDate,
            child: DateSection(eventId: eventId),
          ),
          CardSection(
            title: l10n.formReminders,
            child: ReminderSection(eventId: eventId),
          ),
          CardSection(
            title: l10n.formSms,
            child: SmsSection(eventId: eventId),
          ),
          const SizedBox(height: 24),
          NoteField(eventId: eventId),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: AppButton(
            icon: Icons.check_rounded,
            label: l10n.formSave,
            isLoading: state.isSaving,
            onPressed: () => _save(context, ref),
          ),
        ),
      ),
    );
  }
}
