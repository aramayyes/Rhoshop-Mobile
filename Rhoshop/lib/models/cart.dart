import 'package:flutter/material.dart';
import 'package:rhoshop/mock/db.dart' as MockDb;
import 'package:rhoshop/mock/models/cart_item.dart';

/// Contains cart's state.
class Cart extends ChangeNotifier {
  var _items = <CartItem>{};
  final _loadingStates = <CartOperation>{};

  Set<CartItem> get items => _items;

  double get total {
    double sum = 0;
    for (var item in _items) {
      sum += item.count * item.product.price;
    }

    return sum;
  }

  bool get isEmpty => _items.isEmpty;

  Future<void> load() async {
    try {
      _items = await MockDb.getCart();
    } finally {
      notifyListeners();
    }
  }

  bool isLoading(CartOperation loading) {
    return _loadingStates.contains(loading);
  }

  bool isInCart(CartItem cartItem) {
    return _items.any((item) => item == cartItem);
  }

  Future add(CartItem cartItem) async {
    _items = await MockDb.addToCart(cartItem);
    notifyListeners();
  }

  Future remove(CartItem cartItem, {bool removeAll = true}) async {
    _items = await MockDb.removeFromCard(cartItem, removeAll: removeAll);
    notifyListeners();
  }

  Future order() async {
    _loadingStates.add(CartOperation.order);
    notifyListeners();

    _items = await MockDb.emptyCard();
    _loadingStates.remove(CartOperation.order);

    notifyListeners();
  }
}

enum CartOperation {
  order,
}
