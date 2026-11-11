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
    final time = _parse(state.draft.notifyTime);

    Future<void> pickTime() async {
      final picked = await showTimePicker(context: context, initialTime: time);
      if (picked == null) return;
      String two(int v) => v.toString().padLeft(2, '0');
      form.setNotifyTime('${two(picked.hour)}:${two(picked.minute)}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: const Icon(Icons.schedule_rounded),
          title: Text(l10n.formNotifyTime),
          subtitle: Text(
            MaterialLocalizations.of(context)
                .formatTimeOfDay(time, alwaysUse24HourFormat: true),
          ),
          trailing: const Icon(Icons.edit_rounded),
          onTap: pickTime,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
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

TimeOfDay _parse(String hhmm) {
  final parts = hhmm.split(':');
  return TimeOfDay(
    hour: int.tryParse(parts.first) ?? 9,
    minute: parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
  );
}
