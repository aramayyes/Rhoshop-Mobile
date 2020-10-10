import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:rhoshop/dto/product.dto.dart';

/// Displays product details as a tile (or card).
class ProductTile extends StatelessWidget {
  final ProductDto product;
  final double imageBorderRadius;
  final void Function() onTap;

  ProductTile(this.product, {this.imageBorderRadius = 6.0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(imageBorderRadius),
              child: ProgressiveImage(
                placeholder: AssetImage('assets/images/placeholder.jpg'),
                thumbnail: NetworkImage(product.thumbnail),
                image: NetworkImage(product.image),
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w700),
                ),
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
    );
  }
}
