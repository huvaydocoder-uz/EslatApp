import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../auth/domain/app_user.dart';
import '../../../subscription/domain/plan.dart';

/// Kim kirgani: rasm (yoki bosh harf), ism, Gmail manzili, tarif.
class AccountCard extends StatelessWidget {
  const AccountCard({super.key, required this.user, required this.plan});

  final AppUser user;
  final AppPlan plan;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final name = user.displayName ?? user.email ?? '';
    final photo = user.photoUrl;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: scheme.primaryContainer,
              foregroundImage: photo == null ? null : NetworkImage(photo),
              child: Text(
                name.isEmpty ? '?' : name.characters.first.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  if (user.email != null && user.email != name)
                    Text(user.email!, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Chip(
                    avatar: Icon(
                      plan == AppPlan.pro
                          ? Icons.workspace_premium_rounded
                          : Icons.favorite_rounded,
                      size: 18,
                    ),
                    label: Text(
                      plan == AppPlan.pro
                          ? l10n.settingsPlanPro
                          : l10n.settingsPlanFree,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
