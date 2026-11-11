import 'package:material_ui/material_ui.dart';

import '../../core/l10n/l10n.dart';
import 'state_views.dart';

/// Vaqtinchalik ekran: router to'liq ishlashi uchun keyingi qadamlarda
/// yoziladigan sahifalar o'rnida turadi.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: EmptyView(
        icon: Icons.construction_rounded,
        title: context.l10n.comingSoon,
      ),
    );
  }
}
