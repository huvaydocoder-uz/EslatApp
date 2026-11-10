import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'state_views.dart';

/// Riverpod `AsyncValue` ni 3 holatga ajratib ko'rsatadi:
/// yuklanish → [LoadingView], xatolik → [ErrorView], bo'sh → [empty],
/// aks holda → [data].
///
/// Har bir ekran ro'yxat/ma'lumotni shu widget orqali ko'rsatadi —
/// shunda hech bir ekran "bo'sh oq sahifa" bilan qolib ketmaydi.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    required this.empty,
    this.isEmpty,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget empty;

  /// Ma'lumot "bo'sh"mi? Masalan: `(list) => list.isEmpty`.
  final bool Function(T data)? isEmpty;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => const LoadingView(),
      error: (_, _) => ErrorView(onRetry: onRetry),
      data: (value) => (isEmpty?.call(value) ?? false) ? empty : data(value),
    );
  }
}
