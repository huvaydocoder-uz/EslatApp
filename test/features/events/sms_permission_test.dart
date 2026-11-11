import 'package:eslat/core/platform/native_bridge.dart';
import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers.dart';

class DeniedBridge implements NativeBridge {
  var settingsOpened = 0;

  @override
  bool get supportsReminders => false;

  @override
  Future<void> syncReminders(List<Map<String, Object?>> reminders) async {}

  @override
  var requests = 0;

  @override
  Future<bool> requestPermission(AppPermission permission) async {
    requests++;
    return false;
  }

  @override
  Future<void> openAppSettings() async => settingsOpened++;

  @override
  Future<PickedContact?> pickContact() async => null;
}

void main() {
  final en = l10nFor('en');

  Future<void> openForm(WidgetTester tester, NativeBridge bridge) async {
    usePhoneScreen(tester);
    await tester.pumpWidget(
      testApp(
        user: testUser,
        profile: const UserProfile(locale: 'en'),
        bridge: bridge,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(en.addEvent));
    await tester.pumpAndSettle();
  }

  testWidgets('SMS ruxsati yo\'q: yo\'riqnoma oynasi va sozlamalarni ochish', (
    tester,
  ) async {
    final bridge = DeniedBridge();
    await openForm(tester, bridge);

    // "Izoh" maydonigacha aylantiramiz — SMS qatori pastki tugma ostida qolmasin.
    await tester.scrollUntilVisible(
      find.text(en.formNote),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text(en.formSmsAuto));
    await tester.pumpAndSettle();
    expect(bridge.requests, 1);

    expect(find.text(en.smsPermissionTitle), findsOneWidget);
    expect(find.text(en.smsPermissionSteps), findsOneWidget);

    await tester.tap(find.text(en.openSettings));
    await tester.pumpAndSettle();
    expect(bridge.settingsOpened, 1);
    expect(find.text(en.smsPermissionTitle), findsNothing);

    // Switch yoqilmagan, telefon raqami maydoni chiqmagan.
    expect(find.text(en.formPhone), findsNothing);
  });

  testWidgets('"Yilini bilmayman" tushuntirish bilan ko\'rsatiladi', (
    tester,
  ) async {
    await openForm(tester, DeniedBridge());
    await tester.scrollUntilVisible(
      find.text(en.formYearUnknown),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text(en.formYearUnknownHint), findsOneWidget);
  });
}
