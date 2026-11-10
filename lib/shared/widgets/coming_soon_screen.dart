import 'package:material_ui/material_ui.dart';

import '../../core/constants/app_strings.dart';
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
      body: const EmptyView(
        icon: Icons.construction_rounded,
        title: AppStrings.comingSoon,
      ),
    );
  }
}
