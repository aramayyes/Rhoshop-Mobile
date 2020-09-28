import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/mock/models/cart_item.dart';
import 'package:rhoshop/models/cart.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;

/// Displays list with products in cart and contains a button to make an order.
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: _buildItemsList(cart),
              ),
              _buildOrderSection(context, cart)
            ],
          ),
        ),
      ),
    );
  }

  Container _buildOrderSection(BuildContext context, Cart cart) {
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
                    '\$${cart.total.toStringAsFixed(2)}',
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
                onPressed: cart.isEmpty ? null : () {},
                child: Text(
                  AppLocalization.of(context).orderButtonText,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItemsList(Cart cart) {
    final cartItemsList = cart.items.toList();
    return ListView.separated(
      itemBuilder: (context, index) {
        final cartItem = cartItemsList[index];
        return _buildItemCard(cartItem, context, cart);
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 4,
      ),
      itemCount: cart.items.length,
    );
  }

  Card _buildItemCard(CartItem cartItem, BuildContext context, Cart cart) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 150,
        child: Row(
          children: [
            Image.asset(
              cartItem.product.imgUrl,
            ),
            SizedBox(
              width: 8,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: Theme.of(context).textTheme.headline4,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${cartItem.product.price.toStringAsFixed(2)}',
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
                          color: cartItem.productColor,
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
                    if (cartItem.count > 1) {
                      cart.remove(
                        cartItem,
                        removeAll: false,
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
                      cartItem.count.toString(),
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
                    cart.add(cartItem);
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
}
