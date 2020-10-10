import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rhoshop/api/mutations/all.dart' as Mutations;
import 'package:rhoshop/api/queries/all.dart' as Queries;
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/app_theme.dart' as AppTheme;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/helpers.dart' as Helpers;

/// Displays user profile, i.e. name, phone number, email
/// and allows user to change their name and password.
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  QueryOptions _userQueryOptions;

  /// Update user profile form key.
  final _formKey = GlobalKey<FormState>();

  /// Controls whether or not to show the password in input field.
  var _passwordObscureText = true;

  /// Name from input field.
  String _name;

  /// Password from input field.
  String _password;

  @override
  Widget build(BuildContext context) {
    if (_userQueryOptions == null) {
      _userQueryOptions = QueryOptions(
        documentNode: gql(Queries.user),
      );
    }

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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
          color: AppColors.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalization.of(context).profileScreenTitle,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: _buildUserProfileSection())
            ],
          ),
        ),
      ),
    );
  }

  Query _buildUserProfileSection() {
    return Query(
      options: _userQueryOptions,
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException || result.loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        } else {
          // If the request was of type 'mutation',
          // then the result data key is 'updateUser'.
          UserDto user = UserDto.fromJson(
              result.data['user'] ?? result.data['updateUser']);

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: user.name,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                    ),
                    decoration: AppTheme.constructTextFieldDecoration(
                        AppLocalization.of(context).nameLabelText),
                    validator: (value) =>
                        _name != null && (value.isEmpty || value.length > 100)
                            ? ''
                            : null,
                    onChanged: (value) => _name = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: user.phoneNumber,
                    readOnly: true,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                    ),
                    decoration: AppTheme.constructTextFieldDecoration(
                        AppLocalization.of(context).phoneNumber),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: user.email,
                    readOnly: true,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                    ),
                    decoration: AppTheme.constructTextFieldDecoration(
                        AppLocalization.of(context).email),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _passwordObscureText,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                    ),
                    decoration: AppTheme.constructTextFieldDecoration(
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
                            setState(
                              () {
                                _passwordObscureText = !_passwordObscureText;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    validator: (value) => _password != null &&
                            (value.isEmpty ||
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
                    builder: (client) => PrimaryButton(
                      onPressed: () => _saveUser(user, client),
                      child: Text(
                        AppLocalization.of(context).saveButtonText,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _saveUser(UserDto user, GraphQLClient client) {
    Helpers.dismissKeyboard(context);

    final hasChanges =
        (_name != null && _name != user.name) || (_password != null);
    if (hasChanges && _formKey.currentState.validate()) {
      setState(() {
        _userQueryOptions = QueryOptions(
          documentNode: gql(Mutations.updateUser),
          variables: {
            "updateUserDto": UpdateUserDto(name: _name, password: _password)
          },
        );
        _name = null;
        _password = null;
      });
    }
  }
}
