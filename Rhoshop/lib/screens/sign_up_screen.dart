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

/// Provides functionality for user signing up.
class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

/// Manages visibility for password input field.
class _SignUpScreenState extends State<SignUpScreen> {
  /// Controls whether or not to show the password in input field.
  var _passwordObscureText = true;

  /// Sign in form key.
  final _formKey = GlobalKey<FormState>();

  /// Name from input field.
  String _name;

  /// Phone number from input field.
  String _phoneNumber;

  /// Email address from input field.
  String _email;

  /// Password from input field.
  String _password;

  /// Handles 'Sign up' button presses.
  void onSignUpButtonPressed() {
    if (_formKey.currentState.validate()) {
      print(_phoneNumber);
      print(_name);
      print(_email);
      print(_password);
    }
  }

  /// Handles 'Sign in' button presses.
  void onSignInButtonPressed() {
    Navigator.popAndPushNamed(context, Routes.signIn);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalization.of(context).signUpScreenTitle,
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                                decoration:
                                    AppTheme.constructTextFieldDecoration(
                                        AppLocalization.of(context)
                                            .nameLabelText),
                                validator: (value) => value.isEmpty ? '' : null,
                                onChanged: (value) => _name = value,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                                decoration:
                                    AppTheme.constructTextFieldDecoration(
                                        AppLocalization.of(context)
                                            .phoneNumber),
                                validator: (value) => (value.isEmpty ||
                                        !value.startsWith('+') ||
                                        value.length < 7)
                                    ? ''
                                    : null,
                                onChanged: (value) => _phoneNumber = value,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                                decoration:
                                    AppTheme.constructTextFieldDecoration(
                                        AppLocalization.of(context).email),
                                validator: (value) => (value.isEmpty ||
                                        !RegExp(RegExps.email).hasMatch(value))
                                    ? ''
                                    : null,
                                onChanged: (value) => _email = value,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                obscureText: _passwordObscureText,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                                decoration:
                                    AppTheme.constructTextFieldDecoration(
                                  AppLocalization.of(context).password,
                                  suffixIcon: SizedBox(
                                    height: 20,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: Icon(
                                        _passwordObscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.descriptionText,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordObscureText =
                                              !_passwordObscureText;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                validator: (value) =>
                                    (value.isEmpty || value.length < 6)
                                        ? ''
                                        : null,
                                onChanged: (value) => _password = value,
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              PrimaryButton(
                                onPressed: onSignUpButtonPressed,
                                child: Text(
                                  AppLocalization.of(context).signUp,
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
                              onPressed: onSignInButtonPressed,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                AppLocalization.of(context).hasAccountText,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: AppColors.descriptionText),
                              ),
                            ),
                            FlatButton(
                              onPressed: onSignInButtonPressed,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                AppLocalization.of(context).signIn,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
