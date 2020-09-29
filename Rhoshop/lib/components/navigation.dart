import 'package:flutter/material.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/utils/routes.dart' as Routes;

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
                child: _buildNavigationList(context),
              ),
              _buildCloseButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildNavigationList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(
          thickness: 1,
        ),
        Row(
          children: [
            Icon(
              Icons.person,
              size: 28,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              AppLocalization.of(context).profileNavigationItem,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
        Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppLocalization.of(context).myOrdersNavigationItem,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              width: 16,
            ),
            Icon(
              Icons.shopping_basket,
              size: 28,
            ),
          ],
        ),
        Divider(
          thickness: 1,
        ),
        GestureDetector(
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
                size: 28,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                AppLocalization.of(context).settingsNavigationItem,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
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
