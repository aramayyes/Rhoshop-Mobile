import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhoshop/components/product_item.dart';
import 'package:rhoshop/mock/db.dart' as MockDb;
import 'package:rhoshop/mock/models/product.dart';
import 'package:rhoshop/screens/all.dart';
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
  Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (productsFuture == null) {
      switch (widget.arguments.categoryId) {
        case Ids.newArrivalsPseudocategory:
          productsFuture = MockDb.fetchNewProducts(
              Localizations.localeOf(context).languageCode,
              count: 12);
          break;
        case Ids.bestSellPseudocategory:
          productsFuture = MockDb.fetchBestSellProducts(
              Localizations.localeOf(context).languageCode,
              count: 12);
          break;
        default:
          productsFuture = MockDb.fetchProductsByCategory(
            widget.arguments.categoryId,
            Localizations.localeOf(context).languageCode,
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
    Widget child;
    const crossAxisCount = 2;
    const crossAxisSpacing = 30.0;
    const mainAxisSpacing = 20.0;
    const childAspectRatio = 5 / 8;

    return FutureBuilder<List<Product>>(
      future: productsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          child = GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) => ProductItem(
              snapshot.data[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.product,
                  arguments: ProductScreenArguments(snapshot.data[index].id),
                );
              },
            ),
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
          child: child,
        );
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
