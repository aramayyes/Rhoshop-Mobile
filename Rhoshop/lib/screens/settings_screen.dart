import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/components/locale_selector.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/models/app_locale.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;

/// Displays and allows to change application settings.
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
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalization.of(context).languageSettingsItem,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        Consumer<AppLocale>(
                          builder: (context, appLocale, child) {
                            return LocaleSelector(appLocale);
                          },
                        ),
                      ],
                    ),
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
