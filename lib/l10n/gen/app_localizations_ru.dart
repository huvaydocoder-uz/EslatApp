// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Eslat';

  @override
  String get navHome => 'Главная';

  @override
  String get navEvents => 'Даты';

  @override
  String get navCalendar => 'Календарь';

  @override
  String get navSettings => 'Настройки';

  @override
  String get loginTitle => 'Добро пожаловать!';

  @override
  String get loginSubtitle =>
      'Регистрация бесплатная. Код вводить не нужно — просто выберите свой аккаунт Google.';

  @override
  String get loginWithGoogle => 'Войти через Gmail';

  @override
  String get loginAutoNote =>
      'Войдите один раз — дальше приложение узнает вас само.';

  @override
  String get authErrorNetwork =>
      'Нет подключения к интернету. Проверьте и попробуйте снова.';

  @override
  String get authErrorNotConfigured =>
      'Приложение ещё не подключено к Firebase. Обратитесь к разработчику.';

  @override
  String get authErrorUnknown => 'Не удалось войти. Попробуйте ещё раз.';

  @override
  String get homeTitle => 'Сегодня';

  @override
  String get homeEmptyTitle => 'Сегодня важных дат нет';

  @override
  String get homeEmptyMessage =>
      'Добавьте дни рождения и важные даты близких — мы обязательно напомним вовремя.';

  @override
  String get eventsTitle => 'Важные даты';

  @override
  String get eventsEmptyTitle => 'Пока ничего не добавлено';

  @override
  String get eventsEmptyMessage =>
      'Нажмите кнопку внизу, чтобы добавить первую дату.';

  @override
  String get addEvent => 'Добавить';

  @override
  String get addEventTitle => 'Новая дата';

  @override
  String get editEventTitle => 'Редактирование';

  @override
  String get eventDetailsTitle => 'Подробнее';

  @override
  String get calendarTitle => 'Календарь';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsPlanFree => 'Бесплатный тариф';

  @override
  String get settingsPlanPro => 'Тариф Pro';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsTheme => 'Оформление';

  @override
  String get settingsColor => 'Основной цвет';

  @override
  String get settingsSaveError =>
      'Не удалось сохранить. Проверьте интернет и попробуйте снова.';

  @override
  String get themeModeSystem => 'Система';

  @override
  String get themeModeLight => 'Светлая';

  @override
  String get themeModeDark => 'Тёмная';

  @override
  String get signOut => 'Выйти из аккаунта';

  @override
  String get signOutConfirmTitle => 'Выйти?';

  @override
  String get signOutConfirmMessage =>
      'Ваши данные сохранятся. Войдите снова — и всё будет на месте.';

  @override
  String get cancel => 'Отмена';

  @override
  String get alarmTitle => 'Сегодня важный день!';

  @override
  String get proTitle => 'Eslat Pro';

  @override
  String get loading => 'Загрузка...';

  @override
  String get errorTitle => 'Произошла ошибка';

  @override
  String get errorMessage =>
      'Проверьте подключение к интернету и попробуйте снова.';

  @override
  String get retry => 'Повторить';

  @override
  String get comingSoon => 'Этот раздел скоро появится';

  @override
  String get colorIndigo => 'Индиго';

  @override
  String get colorBlue => 'Синий';

  @override
  String get colorTeal => 'Бирюзовый';

  @override
  String get colorGreen => 'Зелёный';

  @override
  String get colorOlive => 'Оливковый';

  @override
  String get colorAmber => 'Янтарный';

  @override
  String get colorOrange => 'Оранжевый';

  @override
  String get colorCoral => 'Коралловый';

  @override
  String get colorRed => 'Красный';

  @override
  String get colorPink => 'Розовый';

  @override
  String get colorPurple => 'Фиолетовый';

  @override
  String get colorBrown => 'Коричневый';

  @override
  String get categoryBirthday => 'День рождения';

  @override
  String get categoryAnniversary => 'Годовщина свадьбы';

  @override
  String get categoryParentBirthday => 'День рождения родителей';

  @override
  String get categoryMeeting => 'Встреча';

  @override
  String get categoryOther => 'Другое';

  @override
  String get filterAll => 'Все';

  @override
  String get homeUpcomingSection => 'Ближайшие 30 дней';

  @override
  String get homeNothingSoonTitle => 'В ближайшие 30 дней важных дат нет';

  @override
  String get homeNothingSoonMessage => 'Все ваши даты — в разделе «Даты».';

  @override
  String get today => 'Сегодня!';

  @override
  String get tomorrow => 'Завтра';

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'через $count дня',
      many: 'через $count дней',
      few: 'через $count дня',
      one: 'через $count день',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня назад',
      many: '$count дней назад',
      few: '$count дня назад',
      one: '$count день назад',
    );
    return '$_temp0';
  }

  @override
  String turnsAge(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'исполнится $count года',
      many: 'исполнится $count лет',
      few: 'исполнится $count года',
      one: 'исполнится $count год',
    );
    return '$_temp0';
  }

  @override
  String anniversaryYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count года',
      many: '$count лет',
      few: '$count года',
      one: '$count год',
    );
    return '$_temp0';
  }

  @override
  String get formTitle => 'Название';

  @override
  String get formTitleHint => 'Например: День рождения мамы';

  @override
  String get formPerson => 'Кто?';

  @override
  String get formPersonHint => 'Например: Мама';

  @override
  String get formChooseEmoji => 'Выберите значок';

  @override
  String get formDate => 'Дата';

  @override
  String get formYearUnknown => 'Не знаю год';

  @override
  String get formTime => 'Время';

  @override
  String get formNoTime => 'Не указано';

  @override
  String get formRepeatYearly => 'Повторять каждый год';

  @override
  String get formReminders => 'Когда напомнить?';

  @override
  String get reminderOnDay => 'В тот же день';

  @override
  String reminderDaysBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'за $count дня',
      many: 'за $count дней',
      few: 'за $count дня',
      one: 'за $count день',
    );
    return '$_temp0';
  }

  @override
  String get formRemindersLimit => 'В бесплатном тарифе — до 2 напоминаний.';

  @override
  String get formAlarm => 'Будильник';

  @override
  String get formAlarmHint =>
      'В этот день музыка будет играть, пока вы её не остановите.';

  @override
  String get formSms => 'SMS-поздравление';

  @override
  String get formPhone => 'Номер телефона';

  @override
  String get formPhoneHint => '+998 90 123 45 67';

  @override
  String get formSmsText => 'Текст SMS';

  @override
  String get formSmsTextHint => 'С днём рождения!';

  @override
  String get formNote => 'Заметка';

  @override
  String get formSave => 'Сохранить';

  @override
  String get formErrorRequired => 'Заполните это поле';

  @override
  String get formErrorPhone => 'Введите номер в формате +998901234567';

  @override
  String get formErrorYear => 'Для разовой даты укажите год';

  @override
  String get saveError =>
      'Не удалось сохранить. Проверьте интернет и попробуйте снова.';

  @override
  String get deleteAction => 'Удалить';

  @override
  String get deleteConfirmTitle => 'Удалить?';

  @override
  String get deleteConfirmMessage =>
      'Эта дата и её напоминания будут удалены навсегда.';

  @override
  String get detailsNotFoundTitle => 'Дата не найдена';

  @override
  String get detailsNotFoundMessage => 'Возможно, она была удалена.';

  @override
  String get detailsReminders => 'Напоминания';

  @override
  String get detailsAlarmOn => 'Будильник включён';

  @override
  String get detailsAlarmOff => 'Будильник выключен';

  @override
  String get calendarGoToday => 'Сегодня';

  @override
  String get calendarPrevMonth => 'Предыдущий месяц';

  @override
  String get calendarNextMonth => 'Следующий месяц';

  @override
  String get calendarNoEventsDay => 'В этот день важных дат нет';

  @override
  String get demoBanner =>
      'Тестовый режим: данные хранятся, пока приложение открыто. После подключения Firebase всё будет сохраняться в облаке.';

  @override
  String get demoUser => 'Тестовый пользователь';

  @override
  String get formNotifyTime => 'Время напоминания';

  @override
  String get formSmsAuto => 'Отправить SMS-поздравление автоматически';

  @override
  String get formSmsAutoHint =>
      'В этот день во время напоминания SMS уйдёт с вашего телефона, с вашего номера.';

  @override
  String get formPickContact => 'Выбрать из контактов';

  @override
  String get notifySmsSent => 'SMS-поздравление отправлено';

  @override
  String get notifySmsFailed => 'SMS не отправлено — отправьте вручную';

  @override
  String get detailsSmsAuto => 'SMS отправится автоматически';

  @override
  String get formNewType => 'Новый тип';

  @override
  String get newTypeTitle => 'Новый тип даты';

  @override
  String get newTypeName => 'Название типа';

  @override
  String get newTypeNameHint => 'Например: Юбилей на работе';

  @override
  String get createAction => 'Создать';

  @override
  String get settingsCustomTypes => 'Мои типы';

  @override
  String get customTypesEmpty => 'У вас пока нет своих типов.';

  @override
  String get deleteTypeConfirmTitle => 'Удалить тип?';

  @override
  String get deleteTypeConfirmMessage =>
      'Даты этого типа не удалятся — они перейдут в «Другое».';

  @override
  String get emojiOtherLabel => 'Другой эмодзи (с клавиатуры)';

  @override
  String get emojiOtherInvalid => 'Введите один эмодзи';

  @override
  String get done => 'Готово';

  @override
  String get formYearUnknownHint =>
      'Если включить, возраст не считается — напомним только по дню и месяцу. Если год известен, оставьте выключенным: будет «исполнится 60 лет».';

  @override
  String get smsPermissionTitle => 'Нужно разрешение на SMS';

  @override
  String get smsPermissionSteps =>
      'Телефон блокирует разрешение на SMS для приложений, установленных из APK-файла. Его нужно включить один раз:\n\n1. Нажмите «Открыть настройки».\n2. «Разрешения» → «SMS». Если появится окно «Ограниченная настройка» — нажмите ОК и вернитесь назад.\n3. Нажмите ⋮ вверху справа → «Разрешить ограниченные настройки». Телефон может запросить PIN-код.\n4. Снова «Разрешения» → «SMS» → «Разрешить».\n5. Вернитесь в приложение и снова включите «Отправить SMS-поздравление автоматически».\n\nXiaomi / Redmi: в «Другие разрешения» также включите «Отправка SMS».';

  @override
  String get openSettings => 'Открыть настройки';
}
