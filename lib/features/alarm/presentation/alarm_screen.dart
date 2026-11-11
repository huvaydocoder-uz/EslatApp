import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_routes.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../events/domain/event_occurrence.dart';
import '../../events/presentation/events_providers.dart';
import '../../events/presentation/widgets/event_texts.dart';
import 'alarm_controllers.dart';

/// Budilnik chalganda ochiladigan sahifa (qulflangan ekran ustida ham).
/// "To'xtatish" tugmasi ma'lumot yuklanmasa ham doim ishlaydi.
class AlarmScreen extends ConsumerWidget {
  const AlarmScreen({super.key, required this.eventId});

  final String eventId;

  Future<void> _stop(BuildContext context, WidgetRef ref) async {
    await ref.read(alarmControllerProvider.notifier).stop();
    if (context.mounted) context.go(AppRoutes.eventDetails(eventId));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AsyncValueView<EventOccurrence?>(
                  value: ref.watch(eventOccurrenceProvider(eventId)),
                  isEmpty: (o) => o == null,
                  empty: _AlarmInfo(title: l10n.alarmTitle),
                  data: (o) => _AlarmInfo(
                    emoji: o!.event.emoji,
                    title: o.event.title,
                    lines: [
                      l10n.alarmTitle,
                      ?EventTexts.years(l10n, o),
                      ?o.event.personName,
                    ],
                  ),
                ),
              ),
              AppButton(
                icon: Icons.alarm_off_rounded,
                label: l10n.alarmStop,
                onPressed: () => _stop(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlarmInfo extends StatelessWidget {
  const _AlarmInfo({
    required this.title,
    this.emoji = '⏰',
    this.lines = const [],
  });

  final String emoji;
  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 120)),
            const SizedBox(height: 16),
            Text(
              title,
              style: text.headlineMedium,
              textAlign: TextAlign.center,
            ),
            for (final line in lines) ...[
              const SizedBox(height: 8),
              Text(line, style: text.titleMedium, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}
