import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rhoshop/api/api_error.dart';
import 'package:rhoshop/api/gql_client.dart';
import 'package:rhoshop/api/mutations/all.dart' as Mutations;
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/app_theme.dart' as AppTheme;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/helpers.dart' as Helpers;
import 'package:rhoshop/utils/regexps.dart' as RegExps;
import 'package:rhoshop/utils/routes.dart' as Routes;
import 'package:shared_preferences/shared_preferences.dart';

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
  String _email;

  /// Password from input field.
  String _password;

  /// Whether the sign in request is in loading state.
  bool _isLoading = false;

  /// Whether input credentials are valid, i.e. whether input password is valid for the input email).
  bool _areCredentialsValid = true;

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
                  AppLocalization.of(context).signInScreenTitle,
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
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                                decoration:
                                    AppTheme.constructTextFieldDecoration(
                                        AppLocalization.of(context).email),
                                validator: (value) => (!_areCredentialsValid ||
                                        value.isEmpty ||
                                        !RegExp(RegExps.email).hasMatch(value))
                                    ? ''
                                    : null,
                                onChanged: (value) => _email = value,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                obscureText: _obscureText,
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
                                validator: (value) => (!_areCredentialsValid ||
                                        value.isEmpty ||
                                        value.length < 6)
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
                                        : () => _onSignInButtonPressed(
                                            context, client),
                                    child: Text(
                                      AppLocalization.of(context).signIn,
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
                              onPressed: _onSignUpButtonPressed,
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
                              onPressed: _onSignUpButtonPressed,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Handles 'Sign in' button presses.
  void _onSignInButtonPressed(
      BuildContext context, GraphQLClient client) async {
    Helpers.dismissKeyboard(context);

    _areCredentialsValid = true;
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      /// Create user.
      final result = await client.mutate(
        MutationOptions(
          documentNode: gql(Mutations.signIn),
          variables: {
            "signInDto": SignInDto(
              email: _email,
              password: _password,
            )
          },
        ),
      );

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
            _areCredentialsValid = false;
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

      // Parse response.
      final jwt = JwtTokenDto.fromJson(result.data['signIn']);

      // Save access token.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jwt.accessToken);

      // Update graphql client to include jwt token for auth.
      GraphQLProvider.of(context).value =
          createGqlClient(token: jwt.accessToken);

      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    }
  }

  /// Handles 'Sign up' button presses.
  void _onSignUpButtonPressed() {
    Navigator.popAndPushNamed(context, Routes.signUp);
  }
}
