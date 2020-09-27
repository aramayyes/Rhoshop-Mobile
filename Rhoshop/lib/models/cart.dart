import 'package:flutter/material.dart';
import 'package:rhoshop/mock/db.dart' as MockDb;
import 'package:rhoshop/mock/models/cart_item.dart';

/// Contains cart's state.
class Cart extends ChangeNotifier {
  var _items = <CartItem>{};

  Future<void> load() async {
    try {
      _items = await MockDb.getCart();
    } finally {
      notifyListeners();
    }
  }

  bool isInCart(String id) {
    return _items.any((cartItem) => cartItem.product.id == id);
  }

  Future add(CartItem cartItem) async {
    _items = await MockDb.addToCart(cartItem);
    notifyListeners();
  }

  Future remove(String id) async {
    _items = await MockDb.removeFromCard(id);
    notifyListeners();

    print(_items);
  }
}
