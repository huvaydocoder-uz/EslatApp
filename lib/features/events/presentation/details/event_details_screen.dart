import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/state_views.dart';
import '../../domain/event_occurrence.dart';
import '../event_actions.dart';
import '../events_providers.dart';
import 'event_details_body.dart';

/// Bitta muhim kun: katta ko'rinish, tahrirlash va o'chirish.
class EventDetailsScreen extends ConsumerWidget {
  const EventDetailsScreen({super.key, required this.eventId});

  final String eventId;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;
    final deleted = await ref
        .read(eventActionsProvider.notifier)
        .delete(eventId);
    if (!context.mounted) return;
    if (deleted) {
      context.pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final occurrence = ref.watch(eventOccurrenceProvider(eventId));
    final found = occurrence.value != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.eventDetailsTitle),
        actions: [
          if (found) ...[
            IconButton(
              tooltip: l10n.editEventTitle,
              icon: const Icon(Icons.edit_rounded),
              onPressed: () => context.push(AppRoutes.eventEdit(eventId)),
            ),
            IconButton(
              tooltip: l10n.deleteAction,
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => _delete(context, ref),
            ),
          ],
        ],
      ),
      body: AsyncValueView<EventOccurrence?>(
        value: occurrence,
        onRetry: () => ref.invalidate(eventOccurrencesProvider),
        isEmpty: (o) => o == null,
        empty: EmptyView(
          icon: Icons.search_off_rounded,
          title: l10n.detailsNotFoundTitle,
          message: l10n.detailsNotFoundMessage,
        ),
        data: (o) => EventDetailsBody(occurrence: o!),
      ),
    );
  }
}
