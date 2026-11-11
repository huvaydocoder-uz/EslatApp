import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/important_event.dart';
import '../../domain/phone_number.dart';

part 'event_form_state.freezed.dart';

enum EventFormField { title, phone, smsText, year }

enum EventFormError { required, invalidPhone, yearRequired }

/// Forma holati: qoralama + forma bayroqlari.
///
/// `draft.year` doim tanlangan yilni saqlaydi; `yearUnknown` bo'lsa,
/// saqlashda yil olib tashlanadi (foydalanuvchi bayroqni qaytarsa, yil yo'qolmaydi).
@freezed
abstract class EventFormState with _$EventFormState {
  const EventFormState._();

  const factory EventFormState({
    required ImportantEvent draft,
    @Default(false) bool isEditing,
    @Default(false) bool yearUnknown,
    @Default(false) bool smsEnabled,
    @Default('') String phoneInput,
    @Default(false) bool emojiChosenByUser,
    @Default(false) bool submitted,
    @Default(false) bool isSaving,
    @Default(false) bool saveFailed,
    @Default(false) bool smsPermissionDenied,
    @Default(2) int maxReminders,
  }) = _EventFormState;

  /// Xatolar faqat "Saqlash" bosilgandan keyin ko'rsatiladi.
  Map<EventFormField, EventFormError> get errors => {
    if (draft.title.trim().isEmpty)
      EventFormField.title: EventFormError.required,
    if (smsEnabled && phoneInput.trim().isEmpty)
      EventFormField.phone: EventFormError.required
    else if (smsEnabled && PhoneNumber.normalize(phoneInput) == null)
      EventFormField.phone: EventFormError.invalidPhone,
    if (smsEnabled && (draft.smsText?.trim().isEmpty ?? true))
      EventFormField.smsText: EventFormError.required,
    if (!draft.repeatYearly && draft.year == null)
      EventFormField.year: EventFormError.yearRequired,
  };

  EventFormError? visibleError(EventFormField field) =>
      submitted ? errors[field] : null;

  /// Firestore'ga yoziladigan yakuniy ko'rinish.
  ImportantEvent toEvent() {
    String? clean(String? value) =>
        (value == null || value.trim().isEmpty) ? null : value.trim();
    return draft.copyWith(
      title: draft.title.trim(),
      personName: clean(draft.personName),
      year: yearUnknown && draft.repeatYearly ? null : draft.year,
      smsMode: smsEnabled ? SmsMode.device : SmsMode.off,
      phone: smsEnabled ? PhoneNumber.normalize(phoneInput) : null,
      smsText: smsEnabled ? clean(draft.smsText) : null,
      note: clean(draft.note),
    );
  }
}
