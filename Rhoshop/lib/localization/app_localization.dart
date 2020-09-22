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

  //#region Globals
  String get appTitle {
    return Intl.message(
      'Rhoshop',
      name: 'appTitle',
      desc: 'Application title',
    );
  }

  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: 'Login text',
    );
  }

  String get signUp {
    return Intl.message(
      'Log in',
      name: 'signUp',
      desc: 'Signup text',
    );
  }
  //#endregion Globals

  //#region IntroScreen
  String get welcomeMessageTitle {
    return Intl.message(
      'Welcome to Rhoshop',
      name: 'welcomeMessageTitle',
      desc: 'Title of the welcome message that is shown in intro page.',
    );
  }

  String get welcomeMessageBody {
    return Intl.message(
      'Explore Us',
      name: 'welcomeMessageBody',
      desc: 'Body of the welcome message that is shown in intro page.',
    );
  }
  //#endregion
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
