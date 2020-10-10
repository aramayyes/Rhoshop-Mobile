import 'package:flutter/material.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/utils/routes.dart' as Routes;

/// Represents application main navigation menu.
class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.8,
          color: AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Rhoshop icon.
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Image.asset(
                        "assets/icons/ic_launcher.png",
                        width: 100,
                      ),
                    ),
                    _buildNavigationList(context),
                  ],
                ),
              ),
              _buildCloseButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildNavigationList(BuildContext context) {
    const iconSize = 28.0;
    const iconPadding = 16.0;
    const dividerThickness = 1.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(
          thickness: 1,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.profile,
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.person,
                size: iconSize,
              ),
              SizedBox(
                width: iconPadding,
              ),
              Text(
                AppLocalization.of(context).profileNavigationItem,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Divider(
          thickness: dividerThickness,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              Routes.myOrders,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                AppLocalization.of(context).myOrdersNavigationItem,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                width: iconPadding,
              ),
              Icon(
                Icons.shopping_basket,
                size: iconSize,
              ),
            ],
          ),
        ),
        Divider(
          thickness: dividerThickness,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              Routes.settings,
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.settings,
                size: iconSize,
              ),
              SizedBox(
                width: iconPadding,
              ),
              Text(
                AppLocalization.of(context).settingsNavigationItem,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Divider(
          thickness: dividerThickness,
        ),
      ],
    );
  }

  Padding _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.close,
          color: AppColors.secondary,
          size: 40,
        ),
      ),
    );
  }
}
