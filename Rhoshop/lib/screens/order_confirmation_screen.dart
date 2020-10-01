import 'package:flutter/material.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/routes.dart' as Routes;

/// Displays a confirmation and gratitude message for completed order.
class OrderConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimens.screenPadding),
      color: AppColors.primary,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Image.asset(
                      'assets/images/like.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ),
                  Text(
                    AppLocalization.of(context).thankYouMessageText,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppLocalization.of(context).weWillContactText,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(Routes.home));
              },
              child: Text(
                AppLocalization.of(context).backToHomeButtonText,
                style: Theme.of(context).textTheme.button,
              ),
            )
          ],
        ),
      ),
    );
  }
}
