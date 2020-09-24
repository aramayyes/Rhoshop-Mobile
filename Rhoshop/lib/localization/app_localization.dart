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

  //#region SignUpScreen
  String get signUpScreenTitle {
    return Intl.message(
      'Sign up',
      name: 'signUpScreenTitle',
      desc: 'Title of the sign up screen.',
    );
  }

  String get nameLabelText {
    return Intl.message(
      'Name',
      name: 'nameLabelText',
      desc: 'Text of the label for text field that takes user name.',
    );
  }

  String get hasAccountText {
    return Intl.message(
      "Already have an account?",
      name: 'hasAccountText',
      desc: 'Asks whether the user already has an account.',
    );
  }
  //#endregion SignUpScreen

  //#region HomeScreen
  String get searchText {
    return Intl.message(
      "Search",
      name: 'searchText',
      desc: 'Text (title or hint text) of the search bar.',
    );
  }

  String get categoriesSectionTitle {
    return Intl.message(
      "Categories",
      name: 'categoriesSectionTitle',
      desc: 'Title of the categories section.',
    );
  }

  String get newArrivalsSectionTitle {
    return Intl.message(
      "New Arrivals",
      name: 'newArrivalsSectionTitle',
      desc: 'Title of the new Arrivals section.',
    );
  }

  String get bestSellSectionTitle {
    return Intl.message(
      "Best Sell",
      name: 'bestSellSectionTitle',
      desc: 'Title of the best sell section.',
    );
  }

  String get seeAllText {
    return Intl.message(
      "See all",
      name: 'seeAllText',
      desc:
          'Text of the button, which is intended for seeing all items in a section.',
    );
  }
  //#endregion HomeScreen
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