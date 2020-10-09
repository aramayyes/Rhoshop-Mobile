import 'package:flutter/material.dart';
import 'package:rhoshop/mock/models/product.dart';

class MockCartItem {
  Product product;
  ProductSize productSize;
  Color productColor;
  int count;

  MockCartItem(this.product, this.productSize, this.productColor, this.count);

  MockCartItem increment() {
    this.count++;
    return this;
  }

  MockCartItem decrement() {
    if (count > 1) {
      this.count--;
    }
    return this;
  }

  @override
  bool operator ==(other) {
    return other is MockCartItem &&
        this.product.id == other.product.id &&
        productColor == other.productColor &&
        this.productSize == other.productSize;
  }

  @override
  int get hashCode => this.product.id.hashCode;
}
