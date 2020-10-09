import 'package:flutter/material.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;

/// Gradient button that is used as the primary button in the app.
class PrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final bool isLoading;
  final double borderRadius;
  final List<Color> gradientColors;
  final double padding;

  const PrimaryButton({
    Key key,
    @required this.onPressed,
    this.child,
    this.isLoading = false,
    this.borderRadius = Dimens.buttonBorderRadius,
    this.gradientColors = const [
      AppColors.buttonGradientStart,
      AppColors.buttonGradientEnd,
    ],
    this.padding = Dimens.buttonPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            colors: gradientColors,
          ),
        ),
        padding: EdgeInsets.all(padding),
        child: Container(
          constraints: BoxConstraints(minHeight: 30),
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
