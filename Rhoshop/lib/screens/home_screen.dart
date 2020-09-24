import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/mock/db.dart' as MockDb;
import 'package:rhoshop/mock/models/category.dart';
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
              color: AppColors.primary,
              height: double.infinity,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    _buildSearchBar(context),
                    SizedBox(
                      height: 20,
                    ),
                    _buildSectionTitle(
                        context,
                        AppLocalization.of(context).categoriesSectionTitle,
                        () {}),
                    _buildCategories(context),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  /// Builds and returns search bar with dropdown suggestions.
  Widget _buildSearchBar(BuildContext context) {
    const borderRadius = 6.0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(borderRadius),
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
        transitionBuilder: (context, suggestionsBox, animationController) =>
            FadeTransition(
          child: suggestionsBox,
          opacity: CurvedAnimation(
            parent: animationController,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        textFieldConfiguration: TextFieldConfiguration(
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 22),
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
            hintStyle:
                Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 22),
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
    );
  }

  /// Builds and returns a row which contains given title and a 'See all' button.
  Widget _buildSectionTitle(
      BuildContext context, String title, void Function() onSeeAllPress) {
    const verticalPadding = 10.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
          ButtonTheme(
            minWidth: 20,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: onSeeAllPress,
              child: Text(
                AppLocalization.of(context).seeAllText,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Builds and returns categories like a horizontal list.
  Widget _buildCategories(BuildContext context) {
    Widget child;
    const height = 80.0;
    const gapBetweenCategories = 10.0;

    return FutureBuilder<List<Category>>(
      future: MockDb.fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          child = ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: gapBetweenCategories,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.translucent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: height * 2,
                      child: Image.asset(snapshot.data[index].imgUrl),
                    ),
                    Text(
                      snapshot.data[index].name,
                      style: Theme.of(context).textTheme.button.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          // This indicator will be also shown in case of error.
          child = Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        }

        return Container(
          height: height,
          child: child,
        );
      },
    );
  }
}
