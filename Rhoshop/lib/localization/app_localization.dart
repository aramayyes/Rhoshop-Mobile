import 'dart:async';

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

  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: 'Close text.',
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

  String get noItemsFoundText {
    return Intl.message(
      "No items found",
      name: 'noItemsFoundText',
      desc:
          'This text(message) is shown in search suggestions bar, if no item is found.',
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

  //#region NotificationsScreen
  String get notificationsScreenTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsScreenTitle',
      desc: 'Title of the notifications screen.',
    );
  }
  //#endregion NotificationsScreen

  //#region ProductScreen
  String reviewsCaptionText(int reviewsCount) {
    return Intl.message('Reviews: $reviewsCount',
        name: 'reviewsCaptionText',
        desc: 'Title of the reviews caption.',
        args: [reviewsCount]);
  }

  String get descriptionSectionTitle {
    return Intl.message(
      'Description',
      name: 'descriptionSectionTitle',
      desc: 'Title of the description section.',
    );
  }

  String get sizeSectionTitle {
    return Intl.message(
      'Size',
      name: 'sizeSectionTitle',
      desc:
          'Title of the size section, which lets user choose size of the product.',
    );
  }

  String get colorSectionTitle {
    return Intl.message(
      'Color',
      name: 'colorSectionTitle',
      desc:
          'Title of the color section, which lets user choose color of the product.',
    );
  }

  String get addToCartText {
    return Intl.message(
      'ADD TO CART',
      name: 'addToCartText',
      desc:
          'Title of the button, which is intended for adding the product to cart.',
    );
  }

  String get alreadyInCartText {
    return Intl.message(
      'ALREADY IN CART',
      name: 'alreadyInCartText',
      desc:
          'Title of the button, which tells user that the item is already in cart.',
    );
  }
  //#endregion ProductScreen

  //#region CartScreen
  String get cartScreenTitle {
    return Intl.message(
      'Cart',
      name: 'cartScreenTitle',
      desc: 'Title of the cart screen.',
    );
  }

  String get totalCaptionText {
    return Intl.message(
      'Total',
      name: 'totalCaptionText',
      desc: 'Title of the caption that shows total sum of products in cart.',
    );
  }

  String get orderButtonText {
    return Intl.message(
      'Order',
      name: 'orderButtonText',
      desc:
          'Title of the button that is intended for ordering products in the cart.',
    );
  }
  //#endregion CartScreen

  //#region OrderConfirmationScreen
  String get thankYouMessageText {
    return Intl.message(
      'Thank you for your order!',
      name: 'thankYouMessageText',
      desc: 'Gratitude message that is shown to user after making an order.',
    );
  }

  String get weWillContactText {
    return Intl.message(
      'We will contact you shortly to clarify details.',
      name: 'weWillContactText',
      desc:
          'This message is shown to user after making an order to inform that they will be contacted soon to clarify details.',
    );
  }

  String get backToHomeButtonText {
    return Intl.message(
      'Back to Home',
      name: 'backToHomeButtonText',
      desc:
          'Title of the button that is intended for going back to home after making an order.',
    );
  }
  //#endregion OrderConfirmationScreen
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
