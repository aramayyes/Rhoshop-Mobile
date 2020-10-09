/// Represents an item that is inserted to card.
class CartItem {
  int id;
  String product;
  String productSize;
  String productColor;
  int productCount;

  CartItem(
      {this.id,
      this.product,
      this.productSize,
      this.productColor,
      this.productCount});

  CartItem.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        product = map["product"],
        productSize = map["product_size"],
        productColor = map["product_color"],
        productCount = map["product_count"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "product": product,
      "product_size": productSize,
      "product_color": productColor,
      "product_count": productCount,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  /// Checks whether given two cart items are identical.
  ///
  /// Products are identical if they contain same details regardless of ids.
  /// Products are identical if they contain same details regardless of ids.
  static areIdentical(CartItem o1, CartItem o2) {
    return o1.product == o2.product &&
        o1.productSize == o2.productSize &&
        o1.productColor == o2.productColor;
  }
}
