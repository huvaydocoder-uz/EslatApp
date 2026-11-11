/// Muhim kun turi. Nomlari Firestore'dagi `category` qiymati bilan bir xil
/// (firebase/firestore.rules) — o'zgartirilmaydi.
enum EventCategory {
  birthday('🎂'),
  anniversary('💍'),
  parentBirthday('👵'),
  meeting('📅'),
  other('⭐');

  const EventCategory(this.defaultEmoji);

  final String defaultEmoji;

  /// Uchrashuv odatda bir martalik; qolganlari har yili takrorlanadi.
  bool get repeatsByDefault => this != EventCategory.meeting;

  /// Yil sanog'i ma'noli bo'lgan turlar: "30 yoshga to'ladi", "10 yillik".
  bool get countsYears => this != EventCategory.meeting;
}

/// Telefonda tushunarli, Firestore qoidasiga sig'adigan (≤16 belgi) emojilar.
/// Murakkab birikmali emojilar (oila, juftlik) ataylab yo'q.
const eventEmojis = <String>[
  '🎂',
  '🎉',
  '🎁',
  '🎈',
  '🥳',
  '🍰',
  '💐',
  '🌹',
  '🌷',
  '❤️',
  '💍',
  '💒',
  '👰',
  '🤵',
  '💑',
  '👵',
  '👴',
  '👩',
  '👨',
  '👧',
  '👦',
  '👶',
  '🤱',
  '📅',
  '🗓️',
  '⏰',
  '🔔',
  '📞',
  '☕',
  '🍽️',
  '🏥',
  '🎓',
  '💼',
  '✈️',
  '🏠',
  '🕌',
  '⭐',
  '🌙',
  '🎊',
  '🏆',
];
