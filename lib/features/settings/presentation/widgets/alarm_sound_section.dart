import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../alarm/presentation/alarm_controllers.dart';

/// Budilnik musiqasi: telefondan tanlash, tinglab ko'rish, standartga qaytarish.
class AlarmSoundSection extends ConsumerWidget {
  const AlarmSoundSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final name = ref.watch(alarmSoundControllerProvider).value;
    final playing = ref.watch(alarmPreviewProvider);
    final sound = ref.read(alarmSoundControllerProvider.notifier);

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.music_note_rounded),
          title: Text(name ?? l10n.alarmSoundDefault),
          subtitle: Text(l10n.alarmSoundHint),
          isThreeLine: true,
        ),
        ListTile(
          leading: const Icon(Icons.library_music_rounded),
          title: Text(l10n.alarmSoundPick),
          onTap: sound.pick,
        ),
        ListTile(
          leading: Icon(
            playing ? Icons.stop_circle_rounded : Icons.play_circle_rounded,
          ),
          title: Text(playing ? l10n.alarmStop : l10n.alarmSoundPreview),
          onTap: ref.read(alarmPreviewProvider.notifier).toggle,
        ),
        if (name != null)
          ListTile(
            leading: const Icon(Icons.restart_alt_rounded),
            title: Text(l10n.alarmSoundReset),
            onTap: sound.reset,
          ),
      ],
    );
  }
}
