import 'package:eslat/features/auth/data/auth_repository.dart';
import 'package:eslat/features/events/data/events_repository.dart';
import 'package:eslat/features/events/domain/event_category.dart';
import 'package:eslat/features/events/domain/important_event.dart';
import 'package:eslat/features/events/presentation/events_providers.dart';
import 'package:eslat/features/events/presentation/form/event_form_controller.dart';
import 'package:eslat/features/events/presentation/form/event_form_state.dart';
import 'package:eslat/features/profile/data/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers.dart';

void main() {
  late InMemoryEventsRepository repo;
  late ProviderContainer container;

  setUp(() async {
    repo = InMemoryEventsRepository();
    container = ProviderContainer(
      overrides: [
        authStateProvider.overrideWith((ref) => Stream.value(testUser)),
        currentProfileProvider.overrideWith((ref) => Stream.value(null)),
        eventsRepositoryProvider.overrideWithValue(repo),
        todayProvider.overrideWithValue(testToday),
      ],
    );
    addTearDown(container.dispose);
    container.listen(eventsProvider, (_, _) {});
    await container.read(authStateProvider.future);
    await container.read(eventsProvider.future);
  });

  /// Repository o'zgarishi stream orqali provider'ga yetib kelishini kutadi.
  Future<List<ImportantEvent>> savedEvents() async {
    await pumpEventQueue();
    return container.read(eventsProvider).requireValue;
  }

  EventFormController form([String? id]) =>
      container.read(eventFormControllerProvider(id).notifier);
  EventFormState state([String? id]) =>
      container.read(eventFormControllerProvider(id));

  test(
    'nomsiz saqlanmaydi, xato faqat "Saqlash"dan keyin ko\'rinadi',
    () async {
      expect(state().visibleError(EventFormField.title), isNull);
      expect(await form().save(), isFalse);
      expect(
        state().visibleError(EventFormField.title),
        EventFormError.required,
      );
    },
  );

  test('toifa tanlansa emoji va "har yili" moslashadi', () {
    form().setCategory(EventCategory.meeting);
    expect(state().draft.emoji, '📅');
    expect(state().draft.repeatYearly, isFalse);
    form()
      ..setEmoji('☕')
      ..setCategory(EventCategory.birthday);
    expect(state().draft.emoji, '☕', reason: 'tanlangan emoji saqlanadi');
  });

  test(
    'bepul tarif: 2 tadan ortiq eslatma qo\'shilmaydi, kamida 1 ta qoladi',
    () {
      form().toggleReminder(7);
      expect(state().draft.remindDaysBefore, [0, 1]);
      form()
        ..toggleReminder(1)
        ..toggleReminder(7);
      expect(state().draft.remindDaysBefore, [0, 7]);
      form()
        ..toggleReminder(0)
        ..toggleReminder(7);
      expect(state().draft.remindDaysBefore, [7]);
    },
  );

  test('SMS: raqam tekshiriladi va E.164 ko\'rinishida saqlanadi', () async {
    form()
      ..setTitle('  Dadamning tug\'ilgan kuni ')
      ..setSmsEnabled(true)
      ..setPhone('90 12');
    expect(await form().save(), isFalse);
    expect(
      state().visibleError(EventFormField.phone),
      EventFormError.invalidPhone,
    );

    form().setPhone('90 123 45 67');
    expect(await form().save(), isTrue);
    final saved = (await savedEvents()).single;
    expect(saved.title, "Dadamning tug'ilgan kuni");
    expect(saved.phone, '+998901234567');
    expect(saved.smsMode, SmsMode.manual);
  });

  test('"yili noma\'lum" — yil saqlanmaydi', () async {
    form()
      ..setTitle('Opam')
      ..setDate(DateTime(1990, 5, 20))
      ..setYearUnknown(true);
    expect(await form().save(), isTrue);
    final saved = (await savedEvents()).single;
    expect((saved.day, saved.month, saved.year), (20, 5, null));
  });

  test('tahrirlash: id saqlanadi, bo\'shatilgan maydon o\'chadi', () async {
    final id = await repo.create(
      testUser.uid,
      testEvent().copyWith(personName: 'Onam', note: 'Gul olish'),
    );
    await savedEvents();

    expect(state(id).isEditing, isTrue);
    form(id)
      ..setPerson('')
      ..setNote('');
    expect(await form(id).save(), isTrue);
    final saved = (await savedEvents()).single;
    expect(saved.id, id);
    expect(saved.personName, isNull);
    expect(saved.note, isNull);
  });
}
