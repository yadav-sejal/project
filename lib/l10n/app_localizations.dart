import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  // This delegate allows the app to load the localization resources
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // You can access the localization values by calling AppLocalizations.of(context)
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // This method provides a translated string for 'Settings' based on the selected language
  String get title {
    return Intl.message('Settings', name: 'title');
  }

  String get language {
    return Intl.message('Language', name: 'language');
  }

  String get enableNotifications {
    return Intl.message('Enable Notifications', name: 'enable_notifications');
  }

  String get darkMode {
    return Intl.message('Dark Mode', name: 'dark_mode');
  }

  String get selectLanguage {
    return Intl.message('Select Language', name: 'select_language');
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // List of supported languages (en, hi, mr)
    return ['en', 'hi', 'mr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // This method loads the necessary localization resources
    return AppLocalizations();
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
