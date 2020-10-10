import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/service/app_database/app_database.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;

/// Displays cart item details as a tile (or card).
class CartTile extends StatelessWidget {
  final CartItem cartItem;
  final ProductDto product;
  final void Function() onRemove;
  final void Function() onIncrement;
  final void Function() onDecrement;

  const CartTile({
    Key key,
    @required this.cartItem,
    @required this.product,
    @required this.onRemove,
    @required this.onIncrement,
    @required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          color: Color(
                            int.parse(cartItem.productColor, radix: 16),
                          ),
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
                  _buildItemCounter(context)
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(onTap: onRemove, child: Icon(Icons.close)),
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildItemCounter(BuildContext context) {
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
                  onTap: onDecrement,
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
                  onTap: onIncrement,
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
