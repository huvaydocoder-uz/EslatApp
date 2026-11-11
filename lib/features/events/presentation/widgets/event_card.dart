import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/event_occurrence.dart';
import 'event_texts.dart';

/// Muhim kun kartasi: katta emoji, nomi, kim/sana, necha kun qoldi.
/// Bugungi kun ajratib ko'rsatiladi.
class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.occurrence});

  final EventOccurrence occurrence;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final event = occurrence.event;
    final highlight = occurrence.isToday;
    final years = EventTexts.years(l10n, occurrence);
    final subtitle = [
      if (event.personName != null) event.personName!,
      EventTexts.date(context, occurrence),
    ].join(' · ');

    return Card(
      color: highlight ? scheme.primaryContainer : null,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.eventDetails(event.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: highlight
                    ? scheme.surface
                    : scheme.secondaryContainer,
                child: Text(event.emoji, style: const TextStyle(fontSize: 30)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: text.titleMedium),
                    const SizedBox(height: 2),
                    Text(subtitle, style: text.bodyMedium),
                    if (years != null)
                      Text(
                        years,
                        style: text.bodyMedium?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _DaysBadge(daysUntil: occurrence.daysUntil, highlight: highlight),
            ],
          ),
        ),
      ),
    );
  }
}

class _DaysBadge extends StatelessWidget {
  const _DaysBadge({required this.daysUntil, required this.highlight});

  final int daysUntil;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(maxWidth: 96),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: highlight ? scheme.primary : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        EventTexts.relative(context.l10n, daysUntil),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge
            ?.copyWith(color: highlight ? scheme.onPrimary : scheme.onSurface),
      ),
    );
  }
}
