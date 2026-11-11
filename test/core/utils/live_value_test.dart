import 'dart:async';

import 'package:eslat/core/utils/live_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('obunadan keyingi birinchi o\'zgarish ham yo\'qolmaydi', () async {
    var value = 1;
    final changes = StreamController<void>.broadcast();
    final received = <int>[];
    final sub = liveValue(() => value, changes.stream).listen(received.add);

    value = 2;
    changes.add(null); // tinglovchi ulangan zahoti — kutishsiz
    await pumpEventQueue();

    expect(received, [1, 2]);
    await sub.cancel();
    await changes.close();
  });
}
