import 'package:flutter/material.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;

/// Constructs decoration for text fields.
///
/// Customizes border colors and tet padding.
InputDecoration constructTextFieldDecoration(String label, {suffixIcon}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 0),
    alignLabelWithHint: true,
    labelText: label,
    suffixIcon: suffixIcon,
    suffixIconConstraints: BoxConstraints(minHeight: 30),
    labelStyle: TextStyle(
      color: AppColors.descriptionText,
      fontFamily: 'Nunito',
    ),
    errorStyle: TextStyle(height: 0),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.descriptionText),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.descriptionText),
    ),
  );
}

/// Scroll behavior without glow effect.
class WithoutGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
