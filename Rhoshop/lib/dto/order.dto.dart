import 'package:rhoshop/dto/all.dart';

class OrderDto {
  String id;
  DateTime date;
  ProductDto product;
  String productSize;
  String productColor;
  int productCount;

  OrderDto({
    this.id,
    this.date,
    this.product,
    this.productSize,
    this.productColor,
    this.productCount,
  });

  OrderDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json.containsKey('date') ? DateTime.parse(json['date']) : null,
        product = json.containsKey('product')
            ? ProductDto.fromJson(json['product'])
            : null,
        productSize = json['productSize'],
        productColor = json.containsKey('productColor')
            ? 'FF${json['productColor']}'
            : null,
        productCount = json['productCount'];
}
