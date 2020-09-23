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
      desc: 'Application title.',
    );
  }

  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: 'Sign in text.',
    );
  }

  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: 'Sign up text.',
    );
  }

  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Email text.',
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Password text.',
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
  //#endregion IntroScreen

  //#region SignInScreen
  String get signInScreenTitle {
    return Intl.message(
      'Sign in',
      name: 'signInScreenTitle',
      desc: 'Title of the sign in screen.',
    );
  }

  String get noAccountText {
    return Intl.message(
      "Don't have an account?",
      name: 'noAccountText',
      desc: 'Asks whether or not user has an account.',
    );
  }
  //#endregion SignInScreen
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
