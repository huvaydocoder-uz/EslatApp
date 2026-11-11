// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Eslat';

  @override
  String get navHome => 'Home';

  @override
  String get navEvents => 'Dates';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navSettings => 'Settings';

  @override
  String get loginTitle => 'Welcome!';

  @override
  String get loginSubtitle =>
      'Sign-up is free. No codes to type — just pick your Google account.';

  @override
  String get loginWithGoogle => 'Continue with Gmail';

  @override
  String get loginAutoNote =>
      'Sign in once — next time the app will recognize you automatically.';

  @override
  String get authErrorNetwork =>
      'No internet connection. Check it and try again.';

  @override
  String get authErrorNotConfigured =>
      'The app is not connected to Firebase yet. Please contact the developer.';

  @override
  String get authErrorUnknown => 'Couldn\'t sign in. Please try again.';

  @override
  String get homeTitle => 'Today';

  @override
  String get homeEmptyTitle => 'No special days today';

  @override
  String get homeEmptyMessage =>
      'Add birthdays and special dates of your loved ones — we\'ll remind you right on time.';

  @override
  String get eventsTitle => 'Special days';

  @override
  String get eventsEmptyTitle => 'Nothing added yet';

  @override
  String get eventsEmptyMessage =>
      'Tap the button below to add your first date.';

  @override
  String get addEvent => 'Add';

  @override
  String get addEventTitle => 'New special day';

  @override
  String get editEventTitle => 'Edit';

  @override
  String get eventDetailsTitle => 'Details';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsPlanFree => 'Free plan';

  @override
  String get settingsPlanPro => 'Pro plan';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Appearance';

  @override
  String get settingsColor => 'Main color';

  @override
  String get settingsSaveError =>
      'Couldn\'t save. Check your internet and try again.';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutConfirmTitle => 'Sign out?';

  @override
  String get signOutConfirmMessage =>
      'Your data stays safe. Sign in again and everything will be here.';

  @override
  String get cancel => 'Cancel';

  @override
  String get alarmTitle => 'Today is a special day!';

  @override
  String get proTitle => 'Eslat Pro';

  @override
  String get loading => 'Loading...';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorMessage => 'Check your internet connection and try again.';

  @override
  String get retry => 'Try again';

  @override
  String get comingSoon => 'This section is coming soon';

  @override
  String get colorIndigo => 'Indigo';

  @override
  String get colorBlue => 'Blue';

  @override
  String get colorTeal => 'Teal';

  @override
  String get colorGreen => 'Green';

  @override
  String get colorOlive => 'Olive';

  @override
  String get colorAmber => 'Amber';

  @override
  String get colorOrange => 'Orange';

  @override
  String get colorCoral => 'Coral';

  @override
  String get colorRed => 'Red';

  @override
  String get colorPink => 'Pink';

  @override
  String get colorPurple => 'Purple';

  @override
  String get colorBrown => 'Brown';

  @override
  String get categoryBirthday => 'Birthday';

  @override
  String get categoryAnniversary => 'Wedding anniversary';

  @override
  String get categoryParentBirthday => 'Parent\'s birthday';

  @override
  String get categoryMeeting => 'Meeting';

  @override
  String get categoryOther => 'Other';

  @override
  String get filterAll => 'All';

  @override
  String get homeUpcomingSection => 'Next 30 days';

  @override
  String get homeNothingSoonTitle => 'No special days in the next 30 days';

  @override
  String get homeNothingSoonMessage =>
      'All your dates are in the \"Dates\" tab.';

  @override
  String get today => 'Today!';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'in $count days',
      one: 'in $count day',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '$count day ago',
    );
    return '$_temp0';
  }

  @override
  String turnsAge(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'turns $count',
      one: 'turns $count',
    );
    return '$_temp0';
  }

  @override
  String anniversaryYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String get formTitle => 'Title';

  @override
  String get formTitleHint => 'For example: Mom\'s birthday';

  @override
  String get formPerson => 'Who?';

  @override
  String get formPersonHint => 'For example: Mom';

  @override
  String get formChooseEmoji => 'Choose an icon';

  @override
  String get formDate => 'Date';

  @override
  String get formYearUnknown => 'Year unknown';

  @override
  String get formTime => 'Time';

  @override
  String get formNoTime => 'Not set';

  @override
  String get formRepeatYearly => 'Repeat every year';

  @override
  String get formReminders => 'When to remind?';

  @override
  String get reminderOnDay => 'On the day';

  @override
  String reminderDaysBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days before',
      one: '$count day before',
    );
    return '$_temp0';
  }

  @override
  String get formRemindersLimit => 'The free plan allows up to 2 reminders.';

  @override
  String get formAlarm => 'Ring an alarm';

  @override
  String get formAlarmHint => 'On the day, music plays until you stop it.';

  @override
  String get formSms => 'Greeting SMS';

  @override
  String get formPhone => 'Phone number';

  @override
  String get formPhoneHint => '+998 90 123 45 67';

  @override
  String get formSmsText => 'SMS text';

  @override
  String get formSmsTextHint => 'Happy birthday!';

  @override
  String get formNote => 'Note';

  @override
  String get formSave => 'Save';

  @override
  String get formErrorRequired => 'Please fill in this field';

  @override
  String get formErrorPhone => 'Enter the number like +998901234567';

  @override
  String get formErrorYear => 'Set the year for a one-time date';

  @override
  String get saveError => 'Couldn\'t save. Check your internet and try again.';

  @override
  String get deleteAction => 'Delete';

  @override
  String get deleteConfirmTitle => 'Delete?';

  @override
  String get deleteConfirmMessage =>
      'This date and its reminders will be deleted permanently.';

  @override
  String get detailsNotFoundTitle => 'This date was not found';

  @override
  String get detailsNotFoundMessage => 'It may have been deleted.';

  @override
  String get detailsReminders => 'Reminders';

  @override
  String get detailsAlarmOn => 'Alarm is on';

  @override
  String get detailsAlarmOff => 'Alarm is off';

  @override
  String get calendarGoToday => 'Today';

  @override
  String get calendarPrevMonth => 'Previous month';

  @override
  String get calendarNextMonth => 'Next month';

  @override
  String get calendarNoEventsDay => 'No special days on this date';

  @override
  String get demoBanner =>
      'Test mode: data is kept only while the app is open. Once Firebase is connected, everything is saved to the cloud.';

  @override
  String get demoUser => 'Test user';

  @override
  String get formNotifyTime => 'Reminder time';

  @override
  String get formSmsAuto => 'Send greeting SMS automatically';

  @override
  String get formSmsAutoHint =>
      'On the day, at the reminder time, it is sent from your phone and your own number.';

  @override
  String get formPickContact => 'Pick from contacts';

  @override
  String get smsPermissionDenied =>
      'SMS permission was not granted. Turn it on in phone settings.';

  @override
  String get notifySmsSent => 'Greeting SMS sent';

  @override
  String get notifySmsFailed => 'SMS not sent — please send it yourself';

  @override
  String get detailsSmsAuto => 'SMS will be sent automatically';

  @override
  String get formNewType => 'New type';

  @override
  String get newTypeTitle => 'New type of day';

  @override
  String get newTypeName => 'Type name';

  @override
  String get newTypeNameHint => 'For example: Work anniversary';

  @override
  String get createAction => 'Create';

  @override
  String get settingsCustomTypes => 'My types';

  @override
  String get customTypesEmpty => 'You have no custom types yet.';

  @override
  String get deleteTypeConfirmTitle => 'Delete this type?';

  @override
  String get deleteTypeConfirmMessage =>
      'Days of this type stay — they move to \"Other\".';

  @override
  String get emojiOtherLabel => 'Other emoji (from keyboard)';

  @override
  String get emojiOtherInvalid => 'Enter one emoji';

  @override
  String get done => 'Done';
}
