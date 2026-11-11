import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/platform/native_bridge.dart';

import '../../../auth/data/auth_repository.dart';
import '../../../profile/data/profile_repository.dart';
import '../../../subscription/domain/plan.dart';
import '../../data/events_repository.dart';
import '../../domain/custom_category.dart';
import '../../domain/event_category.dart';
import '../../domain/important_event.dart';
import '../../domain/phone_number.dart';
import '../events_providers.dart';
import 'event_form_state.dart';

part 'event_form_controller.g.dart';

/// Qo'shish / tahrirlash formasi. `eventId == null` — yangi kun.
@riverpod
class EventFormController extends _$EventFormController {
  @override
  EventFormState build(String? eventId) {
    final plan = ref.read(currentProfileProvider).value?.plan ?? AppPlan.free;
    final maxReminders = Entitlements.of(plan).maxRemindersPerEvent;
    final existing = eventId == null
        ? null
        : ref
              .read(eventsProvider)
              .value
              ?.where((e) => e.id == eventId)
              .firstOrNull;
    if (existing == null) {
      final today = ref.read(todayProvider);
      return EventFormState(
        draft: ImportantEvent.draft(today).copyWith(year: today.year),
        maxReminders: maxReminders,
      );
    }
    return EventFormState(
      draft: existing.copyWith(
        year: existing.year ?? ref.read(todayProvider).year,
      ),
      isEditing: true,
      yearUnknown: existing.year == null,
      smsEnabled: existing.smsMode != SmsMode.off,
      phoneInput: existing.phone ?? '',
      emojiChosenByUser: true,
      maxReminders: maxReminders,
    );
  }

  void _draft(ImportantEvent Function(ImportantEvent) change) =>
      state = state.copyWith(draft: change(state.draft), saveFailed: false);

  void setTitle(String value) => _draft((d) => d.copyWith(title: value));
  void setPerson(String value) => _draft((d) => d.copyWith(personName: value));
  void setNote(String value) => _draft((d) => d.copyWith(note: value));
  void setSmsText(String value) => _draft((d) => d.copyWith(smsText: value));
  void setAlarm(bool on) => _draft((d) => d.copyWith(alarmEnabled: on));
  void setTime(String? hhmm) => _draft((d) => d.copyWith(time: hhmm));

  void setNotifyTime(String hhmm) =>
      _draft((d) => d.copyWith(notifyTime: hhmm));

  void setPhone(String value) => state = state.copyWith(phoneInput: value);
  void setYearUnknown(bool on) => state = state.copyWith(yearUnknown: on);

  /// Avtomatik SMS: yoqishda telefondan SMS ruxsati so'raladi. Ruxsat
  /// berilmasa — o'chiq qoladi va `smsPermissionDenied` (ekranda xabar).
  Future<void> setSmsEnabled(bool on, {String? defaultText}) async {
    state = state.copyWith(smsPermissionDenied: false);
    if (!on) {
      state = state.copyWith(smsEnabled: false);
      return;
    }
    final granted = await ref
        .read(nativeBridgeProvider)
        .requestPermission(AppPermission.sms);
    if (!ref.mounted) return;
    if (!granted) {
      state = state.copyWith(smsPermissionDenied: true);
      return;
    }
    final needsText = state.draft.smsText?.trim().isEmpty ?? true;
    state = state.copyWith(
      smsEnabled: true,
      draft: needsText && defaultText != null
          ? state.draft.copyWith(smsText: defaultText)
          : state.draft,
    );
  }

  /// SMS ruxsatini qo'lda yoqish uchun telefon sozlamalari.
  Future<void> openAppSettings() =>
      ref.read(nativeBridgeProvider).openAppSettings();

  /// Tizimning kontakt oynasidan raqam (va bo'sh bo'lsa — ism) olinadi.
  Future<void> pickContact() async {
    final contact = await ref.read(nativeBridgeProvider).pickContact();
    if (contact == null || !ref.mounted) return;
    state = state.copyWith(
      phoneInput: PhoneNumber.normalize(contact.phone) ?? contact.phone,
    );
    final name = contact.name;
    if (name != null && (state.draft.personName?.trim().isEmpty ?? true)) {
      setPerson(name);
    }
  }

  /// Toifa tanlansa: emoji (foydalanuvchi o'zi tanlamagan bo'lsa) va
  /// "har yili" standart qiymati moslashadi.
  void setCategory(EventCategory category) {
    final keepEmoji = state.emojiChosenByUser;
    _draft(
      (d) => d.copyWith(
        category: category,
        customCategoryId: null,
        emoji: keepEmoji ? d.emoji : category.defaultEmoji,
        repeatYearly: category.repeatsByDefault,
      ),
    );
    if (!category.repeatsByDefault) setYearUnknown(false);
  }

  /// Foydalanuvchining o'z turi ("Boshqa" sifatida, o'z emojisi bilan).
  void setCustomCategory(CustomCategory custom) {
    final keepEmoji = state.emojiChosenByUser;
    _draft(
      (d) => d.copyWith(
        category: EventCategory.other,
        customCategoryId: custom.id,
        emoji: keepEmoji ? d.emoji : custom.emoji,
        repeatYearly: true,
      ),
    );
  }

  void setEmoji(String emoji) {
    _draft((d) => d.copyWith(emoji: emoji));
    state = state.copyWith(emojiChosenByUser: true);
  }

  void setDate(DateTime date) => _draft(
    (d) => d.copyWith(day: date.day, month: date.month, year: date.year),
  );

  void setRepeatYearly(bool on) {
    _draft((d) => d.copyWith(repeatYearly: on));
    if (!on) setYearUnknown(false);
  }

  /// Tarif chegarasidan oshmaydi (bepul — 2 ta).
  void toggleReminder(int daysBefore) {
    final current = [...state.draft.remindDaysBefore];
    if (current.contains(daysBefore)) {
      if (current.length == 1) return; // kamida bitta eslatma qoladi
      current.remove(daysBefore);
    } else {
      if (current.length >= state.maxReminders) return;
      current.add(daysBefore);
    }
    current.sort();
    _draft((d) => d.copyWith(remindDaysBefore: current));
  }

  /// Muvaffaqiyatli saqlansa `true` (ekran yopiladi).
  Future<bool> save() async {
    if (state.isSaving) return false;
    state = state.copyWith(submitted: true, saveFailed: false);
    if (state.errors.isNotEmpty) return false;
    final user = ref.read(authStateProvider).value;
    if (user == null) return false;

    state = state.copyWith(isSaving: true);
    final repo = ref.read(eventsRepositoryProvider);
    final event = state.toEvent();
    try {
      if (state.isEditing) {
        await repo.update(user.uid, event);
      } else {
        await repo.create(user.uid, event);
      }
      return true;
    } on Exception {
      if (ref.mounted) {
        state = state.copyWith(isSaving: false, saveFailed: true);
      }
      return false;
    }
  }
}
