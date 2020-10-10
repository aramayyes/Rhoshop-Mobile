import 'package:flutter/material.dart';
import 'package:rhoshop/service/app_database/app_database.dart';

/// Contains cart's state.
class Cart extends ChangeNotifier {
  var _items = <CartItem>[];

  List<CartItem> get items => _items;
  bool get isEmpty => _items.isEmpty;

  Future<void> load() async {
    try {
      _items = await AppDatabase.instance.getCartItems();
    } finally {
      notifyListeners();
    }
  }

  CartItem getByDetails(CartItem cartItem) {
    return _items.singleWhere((item) => CartItem.areIdentical(item, cartItem),
        orElse: () => null);
  }

  Future<CartItem> add(CartItem cartItem) async {
    cartItem = await AppDatabase.instance.addCartItem(cartItem);
    _items.insert(0, cartItem);
    notifyListeners();

    return cartItem;
  }

  Future updateCount(CartItem cartItem) async {
    await AppDatabase.instance.updateCartItemCount(cartItem);
    final item = _items.singleWhere((c) => c.id == cartItem.id);
    item.productCount = cartItem.productCount;

    notifyListeners();
  }

  Future remove(CartItem cartItem) async {
    await AppDatabase.instance.removeCartItem(cartItem);
    _items.removeWhere((o) => o.id == cartItem.id);
    notifyListeners();
  }

  Future clear() async {
    await AppDatabase.instance.removeAllCartItems();
    _items.clear();
    notifyListeners();
  }
}
