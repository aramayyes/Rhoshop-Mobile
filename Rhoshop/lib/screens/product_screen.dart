import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/mock/db.dart' as MockDb;
import 'package:rhoshop/mock/models/cart_item.dart';
import 'package:rhoshop/mock/models/product.dart';
import 'package:rhoshop/models/cart.dart';
import 'package:rhoshop/screens/photo_screen.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/routes.dart' as Routes;

// Mock
final productColors = <Color>[
  Colors.black,
  Color(0xFFcfb034),
  Color(0xFFededed),
  Color(0xFF800d0d),
];

/// Displays detailed information about a certain product.
class ProductScreen extends StatefulWidget {
  final ProductScreenArguments arguments;

  const ProductScreen(this.arguments, {Key key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future<Product> _productFuture;

  /// Selected size, which will be included in order.
  ProductSize _selectedSize = ProductSize.M;

  /// Selected color, which be included in order.
  Color _selectedColor = productColors[0];

  @override
  Widget build(BuildContext context) {
    if (_productFuture == null) {
      _productFuture = MockDb.fetchProduct(
        widget.arguments.productId,
        Localizations.localeOf(context).languageCode,
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
        actions: [
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
      body: FutureBuilder(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildProductSection(context, snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(AppColors.secondary),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductSection(BuildContext context, Product product) {
    return Container(
      color: AppColors.primary,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(product),
                SizedBox(height: 20),
                _buildTitle(product, context),
                SizedBox(height: 6),
                _buildPriceRow(product, context),
                Divider(
                  height: 20,
                  thickness: 1,
                ),
                _buildRatingRow(product, context),
                Divider(
                  height: 20,
                  thickness: 1,
                ),
                _buildDescription(context, product),
                Divider(
                  height: 20,
                  thickness: 1,
                ),
                _buildSizeRow(context),
                Divider(
                  height: 20,
                  thickness: 1,
                ),
                _buildColorRow(context),
                SizedBox(
                  height: 100, // Include space for 'Add to card' button.
                ),
              ],
            ),
          ),
          _buildAddToCart(context, product),
        ],
      ),
    );
  }

  Align _buildAddToCart(BuildContext context, Product product) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Consumer<Cart>(
            builder: (context, cart, child) {
              final isInCart = cart.isInCart(
                CartItem(
                  product,
                  _selectedSize,
                  _selectedColor,
                  1,
                ),
              );
              return PrimaryButton(
                borderRadius: 0,
                onPressed: () {
                  isInCart
                      ? cart.remove(
                          CartItem(
                            product,
                            _selectedSize,
                            _selectedColor,
                            1,
                          ),
                        )
                      : cart.add(
                          CartItem(
                            product,
                            _selectedSize,
                            _selectedColor,
                            1,
                          ),
                        );
                },
                child: Text(
                  isInCart
                      ? AppLocalization.of(context).alreadyInCartText
                      : AppLocalization.of(context).addToCartText,
                  style: Theme.of(context).textTheme.button,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Row _buildColorRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalization.of(context).colorSectionTitle,
          style: Theme.of(context).textTheme.headline3,
        ),
        Row(
          children: productColors
              .map<Widget>(
                (color) => _buildColorDot(color),
              )
              .toList(),
        ),
      ],
    );
  }

  GestureDetector _buildColorDot(Color color) {
    final isSelected = color == _selectedColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        height: 36,
        width: 36,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
          border: Border.all(
            color: isSelected ? AppColors.secondary : Colors.transparent,
            width: 4,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }

  Row _buildSizeRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalization.of(context).sizeSectionTitle,
          style: Theme.of(context).textTheme.headline3,
        ),
        Row(
          children: ProductSize.values
              .map<Widget>(
                (productSize) => _buildProductSizeBox(productSize, context),
              )
              .toList(),
        )
      ],
    );
  }

  Padding _buildProductSizeBox(ProductSize productSize, BuildContext context) {
    final isSelected = productSize == _selectedSize;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSize = productSize;
          });
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      )
                    ]
                  : [],
              color: isSelected
                  ? AppColors.secondary
                  : Colors.grey.withOpacity(0.4)),
          child: Center(
            child: Text(
              productSize.toString().split('.').last,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: isSelected
                        ? AppColors.secondaryText
                        : AppColors.primaryText,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildDescription(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalization.of(context).descriptionSectionTitle,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Text _buildTitle(Product product, BuildContext context) {
    return Text(
      product.name,
      style: Theme.of(context)
          .textTheme
          .headline2
          .copyWith(fontWeight: FontWeight.w600),
      maxLines: 2,
    );
  }

  Row _buildRatingRow(Product product, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 80,
          child: PrimaryButton(
            padding: 6,
            onPressed: null,
            child: Text(
              product.rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
        Text(
          AppLocalization.of(context).reviewsCaptionText(product.reviewsCount),
          style: Theme.of(context).textTheme.headline4.copyWith(
                color: AppColors.secondary,
              ),
        ),
      ],
    );
  }

  Widget _buildImage(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  PhotoScreen(
                PhotoScreenArguments(product.imgUrl),
              ),
            ));
      },
      child: Container(
        width: double.infinity,
        child: Hero(
          tag: product.imgUrl,
          child: Image.asset(
            product.imgUrl,
            height: 200,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(Product product, BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headline3.copyWith(
                color: AppColors.secondary,
              ),
        ),
        SizedBox(
          width: 20,
        ),
        if (product.oldPrice != null)
          Text(
            '\$${product.oldPrice.toStringAsFixed(2)}',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(decoration: TextDecoration.lineThrough),
          ),
      ],
    );
  }
}

/// Contains arguments for Product Screen.
class ProductScreenArguments {
  /// Id of the category products of which should be displayed.
  final String productId;

  ProductScreenArguments(
    this.productId,
  );
}
