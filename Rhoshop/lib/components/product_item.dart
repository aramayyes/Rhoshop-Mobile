import 'package:flutter/material.dart';
import 'package:rhoshop/mock/models/product.dart';

/// Represents a single product and contains content about it.
class ProductItem extends StatelessWidget {
  final Product product;
  final double imageBorderRadius;
  final void Function() onTap;

  ProductItem(this.product, {this.imageBorderRadius = 6.0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 5 / 8,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(imageBorderRadius),
                child: Image.asset(
                  product.imgUrl,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text('${product.price}\$',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.w700)),
                ),
                Text(
                  product.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 16),
                  softWrap: false,
                  overflow: TextOverflow.fade,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
