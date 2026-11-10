import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_routes.dart';

/// Katta "Qo'shish" tugmasi — Asosiy va Kunlar ekranlarida.
class AddEventFab extends StatelessWidget {
  const AddEventFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.push(AppRoutes.eventNew),
      icon: const Icon(Icons.add_rounded, size: 28),
      label: const Text(AppStrings.addEvent),
    );
  }
}
