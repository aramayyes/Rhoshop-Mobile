import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/components/locale_selector.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/models/app_locale.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;

/// Welcomes user and provides routes to sign in and sign up screens.
class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Text(
                AppLocalization.of(context).welcomeMessageTitle,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Text(
              AppLocalization.of(context).welcomeMessageBody,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            _buildLanguageRow(),
            Spacer(),
            Image(
              image: AssetImage('assets/images/intro_main_img.png'),
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: PrimaryButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_in');
                },
                child: Text(
                  AppLocalization.of(context).signIn,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  AppLocalization.of(context).signUp,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildLanguageRow() {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Consumer<AppLocale>(
        builder: (context, appLocale, child) {
          return LocaleSelector(appLocale);
        },
      ),
    );
  }
}
