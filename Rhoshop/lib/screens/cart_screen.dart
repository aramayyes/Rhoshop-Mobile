import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/api/mutations/all.dart' as Mutations;
import 'package:rhoshop/api/queries/all.dart' as Queries;
import 'package:rhoshop/components/cart_tile.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/dto/filter_products.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/models/cart.dart';
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

  /// Whether the order request is in loading state.
  bool _isOrderLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context, listen: false).items;

    // Get product with ids contained in cart items.
    if (_productsQueryOptions == null && cartItems.isNotEmpty) {
      _productsQueryOptions = _productsQueryOptions = QueryOptions(
        documentNode: gql(Queries.productsForCart),
        variables: {
          "filter": FilterProductsDto(
            ids: cartItems.map<String>((c) => c.product).toList(),
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
                // If cart is empty, there is no need to make a request for 0 products.
                child: cartItems.isEmpty
                    ? _buildEmptyCart(cart, context)
                    : _buildCart(cart, context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildEmptyCart(Cart cart, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _buildItemsList(cart, []),
        ),
        _buildOrderSection(context, cart, [])
      ],
    );
  }

  Query _buildCart(Cart cart, BuildContext context) {
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
        });
  }

  Widget _buildItemsList(Cart cart, List<ProductDto> products) {
    return ListView.separated(
      itemCount: cart.items.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 4,
      ),
      itemBuilder: (context, index) {
        final cartItem = cart.items[index];

        // Find product of current cart item.
        final product = products.singleWhere((p) => p.id == cartItem.product);
        return CartTile(
          cartItem: cartItem,
          product: product,
          onRemove: () => cart.remove(cartItem),
          onIncrement: () {
            cartItem.productCount++;
            cart.updateCount(
              cartItem,
            );
          },
          onDecrement: () {
            if (cartItem.productCount > 1) {
              cartItem.productCount--;
              cart.updateCount(
                cartItem,
              );
            }
          },
        );
      },
    );
  }

  Container _buildOrderSection(
      BuildContext context, Cart cart, List<ProductDto> products) {
    var totalSum = 0.0;
    for (final cartItem in cart.items) {
      totalSum += cartItem.productCount *
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
                    '\$${totalSum.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
            ],
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GraphQLConsumer(
                builder: (client) => PrimaryButton(
                  onPressed: cart.isEmpty || _isOrderLoading
                      ? null
                      : () => _order(cart, client),
                  child: Text(
                    AppLocalization.of(context).orderButtonText,
                    style: Theme.of(context).textTheme.button,
                  ),
                  isLoading: _isOrderLoading,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _order(Cart cart, GraphQLClient client) async {
    setState(() {
      _isOrderLoading = true;
    });

    /// API server expects a single cart item.
    await Future.wait(
      cart.items
          .map<Future<QueryResult>>(
            (c) => client.mutate(
              MutationOptions(
                documentNode: gql(
                  Mutations.createOrder,
                ),
                variables: {
                  "createOrderDto": CreateOrderDto(
                    product: c.product,
                    productSize: c.productSize,
                    // Color in cart item contains Alpha channel, while
                    // color in server doesn't.
                    productColor: c.productColor.substring(2),
                    productCount: c.productCount,
                  )
                },
              ),
            ),
          )
          .toList(),
    );

    await cart.clear();

    setState(() {
      _isOrderLoading = false;
    });

    Navigator.pushNamed(context, Routes.orderConfirmation);
  }
}
