import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/mock/db.dart' as MockDb;
import 'package:rhoshop/mock/models/cart_item.dart';
import 'package:rhoshop/screens/all.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/routes.dart' as Routes;

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  Future<List<CartItem>> ordersFuture;

  @override
  Widget build(BuildContext context) {
    if (ordersFuture == null) {
      ordersFuture = MockDb.getMyOrders();
    }

    Widget child;

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
        padding: const EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
        color: AppColors.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalization.of(context).myOrdersScreenTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _buildOrdersSection(child),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<CartItem>> _buildOrdersSection(Widget child) {
    return FutureBuilder<List<CartItem>>(
      future: ordersFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          child = snapshot.data.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/blank.svg',
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        AppLocalization.of(context).noOrderText,
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: PrimaryButton(
                        onPressed: () {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(Routes.home),
                          );
                        },
                        child: Text(
                          AppLocalization.of(context).shopNowButtonText,
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    )
                  ],
                )
              : _buildOrdersList(snapshot);
        } else {
          // This indicator will be also shown in case of error.
          child = Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        }

        return Center(
          child: child,
        );
      },
    );
  }

  ListView _buildOrdersList(AsyncSnapshot<List<CartItem>> snapshot) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final cartItem = snapshot.data[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.product,
              arguments: ProductScreenArguments(
                snapshot.data[index].product.id,
              ),
            );
          },
          child: Card(
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 120,
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      DateFormat.MMMMd(
                                        Localizations.localeOf(
                                          context,
                                        ).toString(),
                                      ).format(
                                        DateTime.now(),
                                      ),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Text(
                                    'x${cartItem.count}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '\$${cartItem.product.price.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
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
                                      cartItem.productSize
                                          .toString()
                                          .split('.')
                                          .last,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 4,
      ),
      itemCount: snapshot.data.length,
    );
  }
}
