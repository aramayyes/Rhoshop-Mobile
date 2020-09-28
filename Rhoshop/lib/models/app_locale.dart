import 'package:flutter/material.dart';
import 'package:rhoshop/localization/app_localization.dart';

/// Contains application localization state.
class AppLocale extends ChangeNotifier {
  var _locale = Locale('en', '');

  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    if (locale.languageCode != _locale.languageCode) {
      _locale = locale;
      await AppLocalization.load(locale);

      notifyListeners();
    }
  }
}
