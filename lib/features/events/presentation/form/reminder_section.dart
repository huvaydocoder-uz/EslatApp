import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/important_event.dart';
import 'event_form_controller.dart';

/// Qachon eslatilsin (o'sha kuni, 1/3/7 kun oldin) va budilnik.
class ReminderSection extends ConsumerWidget {
  const ReminderSection({super.key, required this.eventId});

  final String? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(eventFormControllerProvider(eventId));
    final form = ref.read(eventFormControllerProvider(eventId).notifier);
    final selected = state.draft.remindDaysBefore;
    final atLimit = selected.length >= state.maxReminders;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final days in reminderOptions)
                FilterChip(
                  label: Text(
                    days == 0
                        ? l10n.reminderOnDay
                        : l10n.reminderDaysBefore(days),
                  ),
                  selected: selected.contains(days),
                  onSelected: !selected.contains(days) && atLimit
                      ? null
                      : (_) => form.toggleReminder(days),
                ),
            ],
          ),
        ),
        if (atLimit)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              l10n.formRemindersLimit,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        SwitchListTile(
          secondary: const Icon(Icons.alarm_rounded),
          title: Text(l10n.formAlarm),
          subtitle: Text(l10n.formAlarmHint),
          value: state.draft.alarmEnabled,
          onChanged: form.setAlarm,
        ),
      ],
    );
  }
}
