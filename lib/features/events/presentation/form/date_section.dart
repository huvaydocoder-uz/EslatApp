import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/event_category.dart';
import 'event_form_controller.dart';
import 'event_form_state.dart';

/// Sana, "har yili", "yili noma'lum" va (uchrashuv uchun) vaqt.
class DateSection extends ConsumerWidget {
  const DateSection({super.key, required this.eventId});

  final String? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final loc = MaterialLocalizations.of(context);
    final state = ref.watch(eventFormControllerProvider(eventId));
    final form = ref.read(eventFormControllerProvider(eventId).notifier);
    final draft = state.draft;
    final date = DateTime(
      draft.year ?? DateTime.now().year,
      draft.month,
      draft.day,
    );
    final showYear = !(state.yearUnknown && draft.repeatYearly);
    final yearError = state.visibleError(EventFormField.year);

    Future<void> pickDate() async {
      final now = DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: DateTime(now.year + 10, 12, 31),
      );
      if (picked != null) form.setDate(picked);
    }

    Future<void> pickTime() async {
      final parts = draft.time?.split(':');
      final picked = await showTimePicker(
        context: context,
        initialTime: parts == null
            ? const TimeOfDay(hour: 9, minute: 0)
            : TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])),
      );
      if (picked == null) return;
      String two(int v) => v.toString().padLeft(2, '0');
      form.setTime('${two(picked.hour)}:${two(picked.minute)}');
    }

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.calendar_month_rounded),
          title: Text(l10n.formDate),
          subtitle: Text(
            showYear ? loc.formatFullDate(date) : loc.formatShortMonthDay(date),
          ),
          trailing: const Icon(Icons.edit_calendar_rounded),
          onTap: pickDate,
        ),
        if (yearError != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.formErrorYear,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        SwitchListTile(
          secondary: const Icon(Icons.autorenew_rounded),
          title: Text(l10n.formRepeatYearly),
          value: draft.repeatYearly,
          onChanged: form.setRepeatYearly,
        ),
        if (draft.repeatYearly)
          SwitchListTile(
            secondary: const Icon(Icons.help_outline_rounded),
            title: Text(l10n.formYearUnknown),
            value: state.yearUnknown,
            onChanged: form.setYearUnknown,
          ),
        if (draft.category == EventCategory.meeting || draft.time != null)
          ListTile(
            leading: const Icon(Icons.schedule_rounded),
            title: Text(l10n.formTime),
            subtitle: Text(draft.time ?? l10n.formNoTime),
            onTap: pickTime,
            trailing: draft.time == null
                ? null
                : IconButton(
                    tooltip: l10n.cancel,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => form.setTime(null),
                  ),
          ),
      ],
    );
  }
}
