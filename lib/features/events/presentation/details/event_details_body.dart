import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../data/categories_repository.dart';
import '../../domain/event_occurrence.dart';
import '../../domain/important_event.dart';
import '../event_type.dart';
import '../widgets/event_texts.dart';

/// Tafsilotlar: katta emoji, nomi, qachon, eslatmalar, SMS, izoh.
class EventDetailsBody extends ConsumerWidget {
  const EventDetailsBody({super.key, required this.occurrence});

  final EventOccurrence occurrence;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final event = occurrence.event;
    final years = EventTexts.years(l10n, occurrence);
    final type = EventType.of(
      event,
      ref.watch(customCategoriesProvider).value ?? const [],
    );
    final reminders = event.remindDaysBefore
        .map((d) => d == 0 ? l10n.reminderOnDay : l10n.reminderDaysBefore(d))
        .join(', ');

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(child: Text(event.emoji, style: const TextStyle(fontSize: 80))),
        const SizedBox(height: 12),
        Text(
          event.title,
          style: text.headlineMedium,
          textAlign: TextAlign.center,
        ),
        if (event.personName != null)
          Text(
            event.personName!,
            style: text.titleMedium,
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 16),
        Center(
          child: Chip(avatar: Text(type.emoji), label: Text(type.label(l10n))),
        ),
        const SizedBox(height: 16),
        Card(
          color: occurrence.isToday ? scheme.primaryContainer : null,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.event_rounded),
                title: Text(EventTexts.relative(l10n, occurrence.daysUntil)),
                subtitle: Text(
                  [EventTexts.date(context, occurrence), ?years].join(' · '),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.notifications_active_rounded),
                title: Text(l10n.detailsReminders),
                subtitle: Text('$reminders · ${event.notifyTime}'),
              ),
              ListTile(
                leading: Icon(
                  event.alarmEnabled
                      ? Icons.alarm_on_rounded
                      : Icons.alarm_off_rounded,
                ),
                title: Text(
                  event.alarmEnabled
                      ? l10n.detailsAlarmOn
                      : l10n.detailsAlarmOff,
                ),
              ),
              if (event.smsMode != SmsMode.off && event.phone != null)
                ListTile(
                  leading: const Icon(Icons.sms_rounded),
                  title: Text(
                    event.smsMode == SmsMode.device
                        ? '${l10n.detailsSmsAuto}: ${event.phone}'
                        : event.phone!,
                  ),
                  subtitle: event.smsText == null ? null : Text(event.smsText!),
                ),
            ],
          ),
        ),
        if (event.note != null) ...[
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notes_rounded),
              title: Text(l10n.formNote),
              subtitle: Text(event.note!),
            ),
          ),
        ],
      ],
    );
  }
}
