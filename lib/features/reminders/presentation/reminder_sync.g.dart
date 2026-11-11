// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_sync.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Muhim kunlar o'zgarganda telefondagi eslatmalarni (va avtomatik SMS'ni)
/// qayta rejalashtiradi. Chiqilganda ro'yxat bo'sh — hammasi bekor qilinadi.
/// Ma'lumot yuklanayotganda yoki xatoda — mavjud eslatmalarga tegilmaydi.

@ProviderFor(ReminderSync)
final reminderSyncProvider = ReminderSyncProvider._();

/// Muhim kunlar o'zgarganda telefondagi eslatmalarni (va avtomatik SMS'ni)
/// qayta rejalashtiradi. Chiqilganda ro'yxat bo'sh — hammasi bekor qilinadi.
/// Ma'lumot yuklanayotganda yoki xatoda — mavjud eslatmalarga tegilmaydi.
final class ReminderSyncProvider extends $NotifierProvider<ReminderSync, void> {
  /// Muhim kunlar o'zgarganda telefondagi eslatmalarni (va avtomatik SMS'ni)
  /// qayta rejalashtiradi. Chiqilganda ro'yxat bo'sh — hammasi bekor qilinadi.
  /// Ma'lumot yuklanayotganda yoki xatoda — mavjud eslatmalarga tegilmaydi.
  ReminderSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSyncHash();

  @$internal
  @override
  ReminderSync create() => ReminderSync();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$reminderSyncHash() => r'60931cae6a1415af9ce807f5b495a0294bf00c68';

/// Muhim kunlar o'zgarganda telefondagi eslatmalarni (va avtomatik SMS'ni)
/// qayta rejalashtiradi. Chiqilganda ro'yxat bo'sh — hammasi bekor qilinadi.
/// Ma'lumot yuklanayotganda yoki xatoda — mavjud eslatmalarga tegilmaydi.

abstract class _$ReminderSync extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
