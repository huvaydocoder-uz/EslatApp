import 'dart:async';

/// Joriy qiymatni darhol, keyin har o'zgarishda yangisini beruvchi stream.
///
/// O'zgarishlarga obuna tinglovchi ulangan zahoti (sinxron) bo'ladi —
/// `async*` dagidek oraliqda kelgan yangilanish yo'qolib qolmaydi.
Stream<T> liveValue<T>(T Function() current, Stream<void> changes) {
  late final StreamController<T> controller;
  StreamSubscription<void>? subscription;
  controller = StreamController<T>(
    onListen: () {
      controller.add(current());
      subscription = changes.listen((_) => controller.add(current()));
    },
    onCancel: () => subscription?.cancel(),
  );
  return controller.stream;
}
