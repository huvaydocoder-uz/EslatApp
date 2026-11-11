/// Telefonga (AlarmManager) yoziladigan bitta eslatma.
class ScheduledReminder {
  const ScheduledReminder({
    required this.id,
    required this.at,
    required this.title,
    required this.body,
    required this.route,
    required this.repeatYearly,
    this.alarm = false,
    this.smsPhone,
    this.smsText,
    this.smsSentTitle,
    this.smsFailedTitle,
  });

  /// Barqaror raqam: bir xil kun + bir xil "necha kun oldin" → bir xil id.
  final int id;
  final DateTime at;
  final String title;
  final String body;

  /// Bildirishnoma bosilganda ochiladigan sahifa (masalan `/event/abc`).
  final String route;
  final bool repeatYearly;

  /// O'sha kuni musiqali budilnik (to'xtatilmaguncha chaladi).
  final bool alarm;
  final String? smsPhone;
  final String? smsText;
  final String? smsSentTitle;
  final String? smsFailedTitle;

  bool get hasSms => smsPhone != null && smsText != null;

  Map<String, Object?> toMap() => {
    'id': id,
    'at': at.millisecondsSinceEpoch,
    'title': title,
    'body': body,
    'route': route,
    'repeatYearly': repeatYearly,
    'alarm': alarm,
    'smsPhone': smsPhone,
    'smsText': smsText,
    'smsSentTitle': smsSentTitle,
    'smsFailedTitle': smsFailedTitle,
  };
}
