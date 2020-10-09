import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rhoshop/api/queries/all.dart' as Queries;
import 'package:rhoshop/components/product_item.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/screens/product_screen.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/ids.dart' as Ids;
import 'package:rhoshop/utils/routes.dart' as Routes;

/// Displays products which belong to given category.
class CategoryScreen extends StatefulWidget {
  final CategoryScreenArguments arguments;

  const CategoryScreen(this.arguments, {Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  QueryOptions _productsQueryOptions;
  String gqlDataKey;

  @override
  Widget build(BuildContext context) {
    const pseudoSectionElementsCount = 10;
    if (_productsQueryOptions == null) {
      switch (widget.arguments.categoryId) {
        case Ids.newArrivalsPseudocategory:
          gqlDataKey = 'newProducts';
          _productsQueryOptions = QueryOptions(
            documentNode: gql(Queries.newProducts),
            variables: {
              "count": pseudoSectionElementsCount,
              "language": Localizations.localeOf(context).languageCode,
            },
          );
          break;
        case Ids.bestSellPseudocategory:
          gqlDataKey = 'bestSellerProducts';
          _productsQueryOptions = QueryOptions(
            documentNode: gql(Queries.bestSellerProducts),
            variables: {
              "count": pseudoSectionElementsCount,
              "language": Localizations.localeOf(context).languageCode
            },
          );
          break;
        default:
          gqlDataKey = 'products';
          _productsQueryOptions = QueryOptions(
            documentNode: gql(Queries.productsByCategory),
            variables: {
              "filter":
                  FilterProductsDto(category: widget.arguments.categoryId),
              "language": Localizations.localeOf(context).languageCode
            },
          );
      }
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
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
        color: AppColors.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.arguments.title,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: _buildProductsGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    const crossAxisCount = 2;
    const crossAxisSpacing = 30.0;
    const mainAxisSpacing = 20.0;
    const childAspectRatio = 5 / 8;

    return Query(
      options: _productsQueryOptions,
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException || result.loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        } else {
          List<ProductDto> products = result.data[gqlDataKey]
              .map<ProductDto>((p) => ProductDto.fromJson(p))
              .toList();

          return GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) => ProductItem(
              products[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.product,
                  arguments: ProductScreenArguments(products[index].id),
                );
              },
            ),
          );
        }
      },
    );
  }
}

/// Contains arguments for CategoryScreen.
class CategoryScreenArguments {
  /// Title of Category Screen.
  final String title;

  /// Id of the category products of which should be displayed.
  final String categoryId;

  CategoryScreenArguments(
    this.title,
    this.categoryId,
  );
}
