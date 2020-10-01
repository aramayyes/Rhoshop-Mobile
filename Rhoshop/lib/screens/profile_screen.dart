import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/mock/db.dart' as MockDb;
import 'package:rhoshop/mock/models/user.dart';
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
  Future<User> _userFuture;

  /// Controls whether or not to show the password in input field.
  var _passwordObscureText = true;

  /// Name from input field.
  String _name;

  /// Password from input field.
  String _password;

  @override
  Widget build(BuildContext context) {
    if (_userFuture == null) {
      _userFuture = MockDb.fetchUser();
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
              _buildUserProfile()
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<User> _buildUserProfile() {
    return FutureBuilder<User>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: snapshot.data.name,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                    ),
                    decoration: AppTheme.constructTextFieldDecoration(
                        AppLocalization.of(context).nameLabelText),
                    validator: (value) => value.isEmpty ? '' : null,
                    onChanged: (value) => _name = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: snapshot.data.phoneNumber,
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
                    initialValue: snapshot.data.email,
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
                    validator: (value) =>
                        (value.isEmpty || value.length < 6) ? '' : null,
                    onChanged: (value) => _password = value,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  PrimaryButton(
                    onPressed: () => _saveUser(snapshot.data),
                    child: Text(
                      AppLocalization.of(context).saveButtonText,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          ),
        );
      },
    );
  }

  void _saveUser(User user) {
    final hasChanges = (_name != null && _name != user.name) ||
        (_password != null && _password != user.password);
    if (hasChanges) {
      setState(() {
        _userFuture = MockDb.updateUser(name: _name, password: _password);
      });
    }
  }
}
