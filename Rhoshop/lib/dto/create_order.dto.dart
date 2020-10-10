class CreateOrderDto {
  String product;
  String productSize;
  String productColor;
  int productCount;

  CreateOrderDto({
    this.product,
    this.productSize,
    this.productColor,
    this.productCount,
  });

  Map<String, dynamic> toJson() => {
        'product': product,
        'productSize': productSize,
        'productColor': productColor,
        'productCount': productCount,
      };
}
