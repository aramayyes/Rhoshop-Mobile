import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:rhoshop/api/queries/all.dart' as Queries;
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/screens/all.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/routes.dart' as Routes;

/// Displays user orders like a list.
class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  QueryOptions _ordersQueryOptions;

  @override
  Widget build(BuildContext context) {
    if (_ordersQueryOptions == null) {
      _ordersQueryOptions = QueryOptions(
        documentNode: gql(Queries.orders),
        variables: {"language": Localizations.localeOf(context).languageCode},
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
              child: _buildOrdersSection(),
            ),
          ],
        ),
      ),
    );
  }

  Query _buildOrdersSection() {
    return Query(
      options: _ordersQueryOptions,
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException || result.loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        } else {
          List<OrderDto> orders = result.data['orders']
              .map<OrderDto>((o) => OrderDto.fromJson(o))
              .toList();

          return orders.isEmpty
              ? _buildNoItemsView()
              : _buildOrdersList(orders);
        }
      },
    );
  }

  Column _buildNoItemsView() {
    return Column(
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
    );
  }

  ListView _buildOrdersList(List<OrderDto> orders) {
    return ListView.separated(
      itemCount: orders.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 4,
      ),
      itemBuilder: (context, index) {
        final order = orders[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.product,
              arguments: ProductScreenArguments(
                order.product.id,
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
                  ProgressiveImage(
                    placeholder: AssetImage('assets/images/placeholder.jpg'),
                    thumbnail: NetworkImage(order.product.thumbnail),
                    image: NetworkImage(order.product.image),
                    height: 112, // 120 - 8
                    width: 112 /
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
                          order.product.name,
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
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
                                    'x${order.productCount}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '\$${order.product.price.toStringAsFixed(2)}',
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
                                      color: Color(int.parse(order.productColor,
                                          radix: 16)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      order.productSize
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
    );
  }
}
