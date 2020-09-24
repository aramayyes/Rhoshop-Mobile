import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/helpers.dart' as Helpers;

/// Default screen when user is signed in.
///
/// Contains categories, some express sections to view products
/// and also provides search functionality.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              color: AppColors.primaryText,
              height: 24,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/notification.svg",
                color: AppColors.primaryText,
                height: 24,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/filter.svg",
                color: AppColors.primaryText,
                height: 24,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Helpers.dismissKeyboard(context);
          },
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(Dimens.screenPadding),
              height: double.infinity,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 26,
                            offset: Offset(0, 14),
                          )
                        ],
                      ),
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 22),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: SvgPicture.asset(
                              'assets/icons/loupe.svg',
                              color: AppColors.primaryText,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              maxHeight: 20,
                              maxWidth: 60,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            alignLabelWithHint: true,
                            hintText: AppLocalization.of(context).searchText,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 22),
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return ['1', '2', '3'];
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: Icon(Icons.shopping_cart),
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          print(suggestion);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
