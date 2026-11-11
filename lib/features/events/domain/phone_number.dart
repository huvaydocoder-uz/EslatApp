/// Telefon raqamini xalqaro E.164 ko'rinishiga keltirish: `+998901234567`.
///
/// Foydalanuvchi qanday yozsa ham qabul qilinadi: "90 123 45 67",
/// "+998 (90) 123-45-67", "998901234567". O'zbekiston raqamlari 9 xonali
/// yozilsa, oldiga +998 qo'shiladi. Natija Firestore qoidasi bilan bir xil
/// shablonga mos kelmasa — `null`.
abstract final class PhoneNumber {
  static final _e164 = RegExp(r'^\+[1-9][0-9]{7,14}$');

  static String? normalize(String input) {
    final hasPlus = input.trim().startsWith('+');
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return null;

    final String candidate;
    if (hasPlus) {
      candidate = '+$digits';
    } else if (digits.length == 9) {
      candidate = '+998$digits'; // O'zbekiston: 90 123 45 67
    } else if (digits.length == 12 && digits.startsWith('998')) {
      candidate = '+$digits';
    } else {
      candidate = '+$digits';
    }
    return _e164.hasMatch(candidate) ? candidate : null;
  }
}
