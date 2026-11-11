import 'package:material_ui/material_ui.dart';

/// Klaviaturadan kiritilgan matndan bitta emojini ajratadi.
///
/// Birinchi "belgi" (grapheme) olinadi; oddiy harf/raqam/belgi bo'lsa yoki
/// Firestore chegarasidan (16) uzun bo'lsa — `null`.
String? singleEmoji(String input) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) return null;
  final first = trimmed.characters.first;
  if (first.length > 16) return null;
  // Analyzer unicode rejimidagi \u{...} ni tanimaydi; ish vaqtida to'g'ri
  // (test: test/features/events/emoji_input_test.dart).
  final hasPictograph = RegExp(
    // ignore: valid_regexps
    r'\p{Extended_Pictographic}|[\u{1F1E6}-\u{1F1FF}]', // + bayroqlar
    unicode: true,
  );
  return hasPictograph.hasMatch(first) ? first : null;
}
