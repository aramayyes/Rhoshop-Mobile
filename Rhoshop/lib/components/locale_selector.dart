import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/models/app_locale.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Displays country flags for all locales and allows user to select one of them.
class LocaleSelector extends StatelessWidget {
  final AppLocale appLocale;

  const LocaleSelector(
    this.appLocale, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (var i = 0;
        i < AppLocalizationDelegate.supportedLocaleCodes.length;
        i++) {
      final code = AppLocalizationDelegate.supportedLocaleCodes[i];

      children.add(
        GestureDetector(
          onTap: () async {
            if (appLocale.locale.languageCode != code) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('locale', code);

              appLocale.setLocale(
                Locale(code, ''),
              );
            }
          },
          child: Opacity(
            opacity: appLocale.locale.languageCode == code ? 1 : 0.4,
            child: SvgPicture.asset(
              'assets/images/locale_$code.svg',
              height: 32,
            ),
          ),
        ),
      );

      if (i != AppLocalizationDelegate.supportedLocaleCodes.length - 1) {
        children.add(
          SizedBox(
            width: 20,
          ),
        );
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
