import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rhoshop/l10n/messages_all.dart';

/// Manages the localization of the application.
///
/// Holds all multilingual texts as getters.
class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(
      context,
      AppLocalization,
    );
  }

  // list of locales
  String get appTitle {
    return Intl.message(
      'Rhoshop',
      name: 'appTitle',
      desc: 'Application title',
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
