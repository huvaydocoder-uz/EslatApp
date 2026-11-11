import 'package:eslat/core/l10n/app_language.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  test('telefon tili mos bo\'lsa — o\'sha til', () {
    expect(AppLanguage.fromDevice(const [Locale('uz', 'UZ')]), AppLanguage.uz);
    expect(AppLanguage.fromDevice(const [Locale('ru')]), AppLanguage.ru);
    expect(AppLanguage.fromDevice(const [Locale('en', 'US')]), AppLanguage.en);
  });

  test('afzallik ro\'yxatidan birinchi mos til olinadi', () {
    expect(
      AppLanguage.fromDevice(const [Locale('kk'), Locale('ru')]),
      AppLanguage.ru,
    );
  });

  test('mos til yo\'q — ingliz tili', () {
    expect(AppLanguage.fromDevice(const [Locale('tr')]), AppLanguage.en);
    expect(AppLanguage.fromDevice(null), AppLanguage.en);
    expect(AppLanguage.fromCode('xx'), AppLanguage.en);
  });
}
