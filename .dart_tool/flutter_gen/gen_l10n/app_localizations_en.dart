import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get enable_notifications => 'Enable Notifications';

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get select_language => 'Select Language';
}
