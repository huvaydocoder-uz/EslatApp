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
  String get appTagline => 'Не забывайте важные даты близких';

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
  String get calendarEmptyTitle => 'В этом месяце важных дат нет';

  @override
  String get calendarEmptyMessage =>
      'Добавленные даты будут отмечены в календаре.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsAccount => 'Аккаунт';

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
}
