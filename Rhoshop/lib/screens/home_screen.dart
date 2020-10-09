import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/api/queries/all.dart' as Queries;
import 'package:rhoshop/components/navigation.dart';
import 'package:rhoshop/components/product_item.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/models/app_locale.dart';
import 'package:rhoshop/screens/all.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/helpers.dart' as Helpers;
import 'package:rhoshop/utils/ids.dart' as Ids;
import 'package:rhoshop/utils/routes.dart' as Routes;

/// Default screen when user is signed in.
///
/// Contains categories, some express sections to view products
/// and also provides search functionality.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QueryOptions _categoryQueryOptions;
  QueryOptions _newArrivalsQueryOptions;
  QueryOptions _bestsellersQueryOptions;

  /// How many elements should be displayed in a section.
  final _sectionElementsCount = 7;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Provider.of<AppLocale>(context, listen: false).addListener(() {
        final newLocale = Provider.of<AppLocale>(context, listen: false).locale;

        _categoryQueryOptions = QueryOptions(
            documentNode: gql(Queries.categories),
            variables: {"language": newLocale.languageCode});
        _newArrivalsQueryOptions = QueryOptions(
          documentNode: gql(Queries.newProducts),
          variables: {
            "count": _sectionElementsCount,
            "language": newLocale.languageCode,
          },
        );
        _bestsellersQueryOptions = QueryOptions(
          documentNode: gql(Queries.bestSellerProducts),
          variables: {
            "count": _sectionElementsCount,
            "language": newLocale.languageCode,
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_categoryQueryOptions == null) {
      _categoryQueryOptions = QueryOptions(
          documentNode: gql(Queries.categories),
          variables: {
            "language": Localizations.localeOf(context).languageCode
          });
    }
    if (_newArrivalsQueryOptions == null) {
      _newArrivalsQueryOptions = QueryOptions(
        documentNode: gql(Queries.newProducts),
        variables: {
          "count": _sectionElementsCount,
          "language": Localizations.localeOf(context).languageCode
        },
      );
    }
    if (_bestsellersQueryOptions == null) {
      _bestsellersQueryOptions = QueryOptions(
        documentNode: gql(Queries.bestSellerProducts),
        variables: {
          "count": _sectionElementsCount,
          "language": Localizations.localeOf(context).languageCode
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              color: AppColors.primaryText,
              height: 24,
            ),
            onPressed: () {
              _showNavigationDrawer(context);
            },
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/notification.svg",
                color: AppColors.primaryText,
                height: 24,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.notifications,
                );
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/shopping-cart.svg",
                color: AppColors.primaryText,
                height: 24,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.cart,
                );
              },
            ),
          ],
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
              height: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20),
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    _buildSearchBar(context),
                    SizedBox(
                      height: 20,
                    ),
                    _buildSectionTitle(context,
                        AppLocalization.of(context).categoriesSectionTitle),
                    _buildCategories(context),
                    SizedBox(
                      height: 20,
                    ),
                    _buildSectionTitle(
                      context,
                      AppLocalization.of(context).newArrivalsSectionTitle,
                      onSeeAllPress: () {
                        Navigator.pushNamed(
                          context,
                          Routes.category,
                          arguments: CategoryScreenArguments(
                              AppLocalization.of(context)
                                  .newArrivalsSectionTitle,
                              Ids.newArrivalsPseudocategory),
                        );
                      },
                    ),
                    _buildSection(
                      context,
                      _newArrivalsQueryOptions,
                      'newProducts',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildSectionTitle(
                      context,
                      AppLocalization.of(context).bestSellSectionTitle,
                      onSeeAllPress: () {
                        Navigator.pushNamed(
                          context,
                          Routes.category,
                          arguments: CategoryScreenArguments(
                              AppLocalization.of(context).bestSellSectionTitle,
                              Ids.bestSellPseudocategory),
                        );
                      },
                    ),
                    _buildSection(
                      context,
                      _bestsellersQueryOptions,
                      'bestSellerProducts',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future _showNavigationDrawer(BuildContext context) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, child) {
        final curvedValue = Curves.easeInOut.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: Container(
              child: child,
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Navigation(),
    );
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
      child: GraphQLConsumer(
        builder: (client) => TypeAheadField<ProductDto>(
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
          hideOnError: true,
          transitionBuilder: (context, suggestionsBox, animationController) =>
              FadeTransition(
            child: suggestionsBox,
            opacity: CurvedAnimation(
              parent: animationController,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          loadingBuilder: (context) => Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
              ),
            ),
          ),
          errorBuilder: (context, error) => Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
              ),
            ),
          ),
          noItemsFoundBuilder: (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              AppLocalization.of(context).noItemsFoundText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).disabledColor, fontSize: 18.0),
            ),
          ),
          suggestionsCallback: (pattern) async {
            if (pattern.length < 3) {
              return [];
            }

            final result = await client.query(
              QueryOptions(
                documentNode: gql(Queries.productSearchSuggestions),
                variables: {
                  "filter": FilterProductsDto(name: pattern),
                  "language": Localizations.localeOf(context).languageCode
                },
              ),
            );

            if (result.hasException) {
              throw result.exception;
            } else {
              return result.data['products']
                  .map<ProductDto>((p) => ProductDto.fromJson(p))
                  .toList();
            }
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: ClipOval(
                child: ProgressiveImage(
                  placeholder: AssetImage('assets/images/placeholder.jpg'),
                  thumbnail: NetworkImage(suggestion.thumbnail),
                  image: NetworkImage(suggestion.image),
                  height: 40,
                  width: 40,
                ),
              ),
              title: Text(suggestion.name),
            );
          },
          onSuggestionSelected: (suggestion) {
            Navigator.pushNamed(
              context,
              Routes.product,
              arguments: ProductScreenArguments(suggestion.id),
            );
          },
        ),
      ),
    );
  }

  /// Builds and returns a row which contains given title and a 'See all' button.
  Widget _buildSectionTitle(BuildContext context, String title,
      {void Function() onSeeAllPress}) {
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
          if (onSeeAllPress != null)
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
            ),
        ],
      ),
    );
  }

  /// Builds and returns categories like a horizontal list.
  Widget _buildCategories(BuildContext context) {
    Widget child;
    const height = 80.0;
    const gapBetweenCategories = 10.0;
    const imageBorderRadius = 6.0;

    return Query(
      options: _categoryQueryOptions,
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException || result.loading) {
          child = Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        } else {
          List<CategoryDto> categories = result.data['categories']
              .map<CategoryDto>((c) => CategoryDto.fromJson(c))
              .toList();

          child = ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: gapBetweenCategories,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.category,
                    arguments: CategoryScreenArguments(
                      category.name,
                      category.id,
                    ),
                  );
                },
                behavior: HitTestBehavior.translucent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(imageBorderRadius),
                      child: ProgressiveImage(
                        placeholder:
                            AssetImage('assets/images/placeholder.jpg'),
                        thumbnail: NetworkImage(category.thumbnail),
                        image: NetworkImage(category.image),
                        height: height,
                        width: height * 2,
                      ),
                    ),
                    Text(
                      category.name,
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              );
            },
          );
        }

        return Container(
          height: height,
          child: child,
        );
      },
    );
  }

  /// Builds and returns a section, i.e. a horizontal list with given products.
  ///
  /// sqlDataKey is used to get data from result.
  Widget _buildSection(
      BuildContext context, QueryOptions options, String gqlDataKey) {
    Widget child;
    const height = 200.0;
    const gapBetweenCategories = 10.0;

    return Query(
      options: options,
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException || result.loading) {
          child = Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        } else {
          List<ProductDto> products = result.data[gqlDataKey]
              .map<ProductDto>((p) => ProductDto.fromJson(p))
              .toList();

          child = ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: gapBetweenCategories,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) => AspectRatio(
              aspectRatio: 5 / 8,
              child: ProductItem(
                products[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.product,
                    arguments: ProductScreenArguments(products[index].id),
                  );
                },
              ),
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
