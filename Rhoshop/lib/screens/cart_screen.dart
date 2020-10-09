import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/api/queries/all.dart' as Queries;
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/dto/filter_products.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/models/cart.dart';
import 'package:rhoshop/service/app_database/app_database.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/routes.dart' as Routes;

/// Displays list with products in cart and contains a button to make an order.
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  QueryOptions _productsQueryOptions;

  @override
  Widget build(BuildContext context) {
    // Get product with ids contained in cart items.
    if (_productsQueryOptions == null) {
      _productsQueryOptions = _productsQueryOptions = QueryOptions(
        documentNode: gql(Queries.productsForCart),
        variables: {
          "filter": FilterProductsDto(
            ids: Provider.of<Cart>(context, listen: false)
                .items
                .map<String>((c) => c.product)
                .toList(),
          ),
          "language": Localizations.localeOf(context).languageCode
        },
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
        color: AppColors.primary,
        child: Consumer<Cart>(
          builder: (context, cart, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalization.of(context).cartScreenTitle,
                style: Theme.of(context).textTheme.headline1,
              ),
              Expanded(
                child: Query(
                    options: _productsQueryOptions,
                    builder: (result, {fetchMore, refetch}) {
                      if (result.hasException || result.loading) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                AppColors.secondary),
                          ),
                        );
                      } else {
                        List<ProductDto> products = result.data['products']
                            .map<ProductDto>((p) => ProductDto.fromJson(p))
                            .toList();

                        // If products are deletable in server
                        // then products got from server should be compared with
                        // cart items and cart items for which no product is fetched
                        // should be removed from card.

                        return Column(
                          children: [
                            Expanded(
                              child: _buildItemsList(cart, products),
                            ),
                            _buildOrderSection(context, cart, products)
                          ],
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemsList(Cart cart, List<ProductDto> products) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final orderEntity = cart.items[index];

        // Find product of current cart item.
        final product =
            products.singleWhere((p) => p.id == orderEntity.product);
        return _buildItemCard(orderEntity, product, context, cart);
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 4,
      ),
      itemCount: cart.items.length,
    );
  }

  Card _buildItemCard(
      CartItem cartItem, ProductDto product, BuildContext context, Cart cart) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 150,
        child: Row(
          children: [
            ProgressiveImage(
              placeholder: AssetImage('assets/images/placeholder.jpg'),
              thumbnail: NetworkImage(product.thumbnail),
              image: NetworkImage(product.image),
              height: 142, // 150 - 8
              width: 142 /
                  1.2, // All product images from server have this aspect ratio.
            ),
            SizedBox(
              width: 8,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headline4,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(int.parse('FF${cartItem.productColor}',
                              radix: 16)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          cartItem.productSize.toString().split('.').last,
                        ),
                      )
                    ],
                  ),
                  _buildItemCounter(cartItem, cart, context)
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                  onTap: () {
                    cart.remove(cartItem);
                  },
                  child: Icon(Icons.close)),
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildItemCounter(
      CartItem cartItem, Cart cart, BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 120,
          height: 40,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (cartItem.productCount > 1) {
                      cartItem.productCount--;
                      cart.updateCount(
                        cartItem,
                      );
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        '-',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    color: Colors.black12,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text(
                      cartItem.productCount.toString(),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  color: Colors.black12,
                ),
              ),
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    cartItem.productCount++;
                    cart.updateCount(
                      cartItem,
                    );
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        '+',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    color: Colors.black12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildOrderSection(
      BuildContext context, Cart cart, List<ProductDto> products) {
    var total = 0.0;
    for (final cartItem in cart.items) {
      total += cartItem.productCount *
          products.singleWhere((p) => p.id == cartItem.product).price;
    }

    return Container(
      height: 140,
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: AppColors.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(context).totalCaptionText,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
            ],
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: PrimaryButton(
                onPressed: cart.isEmpty || cart.isLoading(CartOperation.order)
                    ? null
                    : () async {
                        // TODO: add order functionality
                        //await cart.order();
                        Navigator.pushNamed(context, Routes.orderConfirmation);
                      },
                child: Text(
                  AppLocalization.of(context).orderButtonText,
                  style: Theme.of(context).textTheme.button,
                ),
                isLoading: cart.isLoading(CartOperation.order),
              ),
            ),
          )
        ],
      ),
    );
  }
}
