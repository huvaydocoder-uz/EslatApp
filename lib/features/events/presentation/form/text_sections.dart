import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../shared/widgets/app_text_field.dart';
import 'event_form_controller.dart';
import 'event_form_state.dart';

/// Nomi va kim (Firestore chegaralari: 80 va 60 belgi).
class BasicsSection extends ConsumerWidget {
  const BasicsSection({super.key, required this.eventId});

  final String? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final provider = eventFormControllerProvider(eventId);
    final state = ref.watch(provider);
    final form = ref.read(provider.notifier);
    return Column(
      spacing: 16,
      children: [
        AppTextField(
          initialValue: state.draft.title,
          onChanged: form.setTitle,
          label: l10n.formTitle,
          hint: l10n.formTitleHint,
          icon: Icons.title_rounded,
          maxLength: 80,
          errorText: state.visibleError(EventFormField.title) == null
              ? null
              : l10n.formErrorRequired,
        ),
        AppTextField(
          initialValue: state.draft.personName ?? '',
          onChanged: form.setPerson,
          label: l10n.formPerson,
          hint: l10n.formPersonHint,
          icon: Icons.person_rounded,
          maxLength: 60,
          textCapitalization: TextCapitalization.words,
        ),
      ],
    );
  }
}

/// Tabrik SMS: yoqilsa — raqam va matn.
class SmsSection extends ConsumerWidget {
  const SmsSection({super.key, required this.eventId});

  final String? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final provider = eventFormControllerProvider(eventId);
    final state = ref.watch(provider);
    final form = ref.read(provider.notifier);
    final phoneError = switch (state.visibleError(EventFormField.phone)) {
      EventFormError.required => l10n.formErrorRequired,
      EventFormError.invalidPhone => l10n.formErrorPhone,
      _ => null,
    };
    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.sms_rounded),
          title: Text(l10n.formSmsAuto),
          subtitle: Text(l10n.formSmsAutoHint),
          value: state.smsEnabled,
          onChanged: (on) =>
              form.setSmsEnabled(on, defaultText: l10n.formSmsTextHint),
        ),
        if (state.smsEnabled)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              spacing: 16,
              children: [
                AppTextField(
                  initialValue: state.phoneInput,
                  onChanged: form.setPhone,
                  label: l10n.formPhone,
                  hint: l10n.formPhoneHint,
                  icon: Icons.phone_rounded,
                  keyboardType: TextInputType.phone,
                  maxLength: 24,
                  errorText: phoneError,
                  suffix: IconButton(
                    tooltip: l10n.formPickContact,
                    icon: const Icon(Icons.contacts_rounded),
                    onPressed: form.pickContact,
                  ),
                ),
                AppTextField(
                  initialValue: state.draft.smsText ?? '',
                  onChanged: form.setSmsText,
                  label: l10n.formSmsText,
                  hint: l10n.formSmsTextHint,
                  icon: Icons.message_rounded,
                  maxLines: 3,
                  maxLength: 300,
                  errorText: state.visibleError(EventFormField.smsText) == null
                      ? null
                      : l10n.formErrorRequired,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Izoh (≤500 belgi).
class NoteField extends ConsumerWidget {
  const NoteField({super.key, required this.eventId});

  final String? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = eventFormControllerProvider(eventId);
    return AppTextField(
      initialValue: ref.watch(provider).draft.note ?? '',
      onChanged: ref.read(provider.notifier).setNote,
      label: context.l10n.formNote,
      icon: Icons.notes_rounded,
      maxLines: 3,
      maxLength: 500,
    );
  }
}
