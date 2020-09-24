import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/app_theme.dart' as AppTheme;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/helpers.dart' as Helpers;
import 'package:rhoshop/utils/regexps.dart' as RegExps;
import 'package:rhoshop/utils/routes.dart' as Routes;

/// Provides functionality for user signing in.
class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

/// Manages visibility for password input field.
class _SignInScreenState extends State<SignInScreen> {
  /// Controls whether or not to show the password in input field.
  var _obscureText = true;

  /// Sign in form key.
  final _formKey = GlobalKey<FormState>();

  /// Email address from input field.
  String email;

  /// Password from input field.
  String password;

  /// Handles 'Sign in' button presses.
  void onSignInButtonPressed() {
    // TODO: perform validation and make a request to sign in
    Navigator.pushNamed(context, Routes.home);
  }

  /// Handles 'Sign up' button presses.
  void onSignUpButtonPressed() {
    Navigator.popAndPushNamed(context, Routes.signUp);
  }

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
          )),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Helpers.dismissKeyboard(context);
        },
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalization.of(context).signInScreenTitle,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: AppTheme.constructTextFieldDecoration(
                              AppLocalization.of(context).email),
                          validator: (value) => (value.isEmpty ||
                                  !RegExp(RegExps.email).hasMatch(value))
                              ? ''
                              : null,
                          onChanged: (value) => email = value,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          decoration: AppTheme.constructTextFieldDecoration(
                            AppLocalization.of(context).password,
                            suffixIcon: SizedBox(
                              height: 20,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.descriptionText,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                          validator: (value) =>
                              (value.isEmpty || value.length < 6) ? '' : null,
                          onChanged: (value) => password = value,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        PrimaryButton(
                          onPressed: onSignInButtonPressed,
                          child: Text(
                            AppLocalization.of(context).signIn,
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        onPressed: onSignUpButtonPressed,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          AppLocalization.of(context).noAccountText,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: AppColors.descriptionText),
                        ),
                      ),
                      FlatButton(
                        onPressed: onSignUpButtonPressed,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          AppLocalization.of(context).signUp,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
