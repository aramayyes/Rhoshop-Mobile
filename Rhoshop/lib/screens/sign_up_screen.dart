import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rhoshop/api/api_error.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/app_theme.dart' as AppTheme;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/helpers.dart' as Helpers;
import 'package:rhoshop/utils/regexps.dart' as RegExps;
import 'package:rhoshop/utils/routes.dart' as Routes;
import 'package:rhoshop/api/mutations/all.dart' as Mutations;
import 'package:rhoshop/dto/all.dart';

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

  /// Whether the sign up request is in loading state.
  bool _isLoading = false;

  /// Whether input email already exist in api server.
  bool _isEmailDuplicate = false;

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
                                validator: (value) =>
                                    value.isEmpty || value.length > 100
                                        ? ''
                                        : null,
                                onChanged: (value) => _name = value.trim(),
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
                                        value.length < 10)
                                    ? ''
                                    : null,
                                onChanged: (value) =>
                                    _phoneNumber = value.trim(),
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
                                validator: (value) => (_isEmailDuplicate ||
                                        value.isEmpty ||
                                        !RegExp(RegExps.email)
                                            .hasMatch(value) ||
                                        value.length > 100)
                                    ? ''
                                    : null,
                                onChanged: (value) => _email = value.trim(),
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
                                validator: (value) => (value.isEmpty ||
                                        value.length < 6 ||
                                        value.length > 20)
                                    ? ''
                                    : null,
                                onChanged: (value) => _password = value,
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              GraphQLConsumer(
                                builder: (client) => Builder(
                                  builder: (context) => PrimaryButton(
                                    onPressed: _isLoading
                                        ? null
                                        : () => _onSignUpButtonPressed(
                                            context, client),
                                    child: Text(
                                      AppLocalization.of(context).signUp,
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    isLoading: _isLoading,
                                  ),
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
                              onPressed: _onSignInButtonPressed,
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
                              onPressed: _onSignInButtonPressed,
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

  /// Handles 'Sign up' button presses.
  void _onSignUpButtonPressed(
      BuildContext context, GraphQLClient client) async {
    Helpers.dismissKeyboard(context);

    _isEmailDuplicate = false;
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      /// Create user
      final result = await client.mutate(
          MutationOptions(documentNode: gql(Mutations.createUser), variables: {
        "createUserDto": CreateUserDto(
          name: _name,
          email: _email,
          password: _password,
          phoneNumber: _phoneNumber,
        )
      }));

      setState(() {
        _isLoading = false;
      });

      // Manage exception if there is any.
      if (result.exception != null) {
        final error = parseApiError(result.exception);

        switch (error) {
          case ApiError.client:
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                AppLocalization.of(context).connectionError,
                style: TextStyle(fontFamily: 'Nunito'),
              ),
            ));
            return;
          case ApiError.badUserInput:
            _isEmailDuplicate = true;
            _formKey.currentState.validate();
            return;
          default:
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                AppLocalization.of(context).serverError,
                style: TextStyle(fontFamily: 'Nunito'),
              ),
            ));
            return;
        }
      }

      // Navigate to sign in screen if registration is successful.
      Navigator.popAndPushNamed(context, Routes.signIn);
    }
  }

  /// Handles 'Sign in' button presses.
  void _onSignInButtonPressed() {
    Navigator.popAndPushNamed(context, Routes.signIn);
  }
}
