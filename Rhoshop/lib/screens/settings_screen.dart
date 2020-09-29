import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/models/app_locale.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/left-arrow.svg",
            color: AppColors.primaryText,
            height: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: AppColors.primary,
        padding: EdgeInsets.all(Dimens.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalization.of(context).settingsScreenTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalization.of(context).languageSettingsItem,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Consumer<AppLocale>(
                        builder: (context, appLocale, child) {
                          final selectedEnglish =
                              appLocale.locale.languageCode == 'en';

                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (!selectedEnglish) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString('counter', 'en');

                                    appLocale.setLocale(
                                      Locale('en', ''),
                                    );
                                  }
                                },
                                child: Opacity(
                                  opacity: selectedEnglish ? 1 : 0.4,
                                  child: SvgPicture.asset(
                                    'assets/images/united-states.svg',
                                    height: 32,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (selectedEnglish) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString('counter', 'ru');

                                    appLocale.setLocale(
                                      Locale('ru', ''),
                                    );
                                  }
                                },
                                child: Opacity(
                                  opacity: !selectedEnglish ? 1 : 0.4,
                                  child: SvgPicture.asset(
                                    'assets/images/russia.svg',
                                    height: 32,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
