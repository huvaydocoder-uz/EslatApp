import 'package:eslat/core/l10n/app_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('standart til — o\'zbekcha', () {
    expect(AppLanguage.defaultLanguage, AppLanguage.uz);
  });

  test('saqlangan kod bo\'yicha; noma\'lum — o\'zbekcha', () {
    expect(AppLanguage.fromCode('ru'), AppLanguage.ru);
    expect(AppLanguage.fromCode('en'), AppLanguage.en);
    expect(AppLanguage.fromCode('xx'), AppLanguage.uz);
    expect(AppLanguage.fromCode(null), AppLanguage.uz);
  });

  test('har bir tilning bayrog\'i bor', () {
    expect(AppLanguage.values.map((l) => l.flag), ['🇺🇿', '🇷🇺', '🇬🇧']);
  });
}
