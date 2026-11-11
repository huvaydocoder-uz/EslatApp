import 'package:eslat/features/events/presentation/widgets/emoji_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emoji va bayroq qabul qilinadi, birinchisi olinadi', () {
    expect(singleEmoji('🎂'), '🎂');
    expect(singleEmoji(' 🇺🇿 '), '🇺🇿');
    expect(singleEmoji('❤️❤️'), '❤️');
  });

  test('harf, raqam, bo\'sh — rad etiladi', () {
    for (final input in ['', '  ', 'a', 'Salom', '1', '?']) {
      expect(singleEmoji(input), isNull, reason: input);
    }
  });
}
