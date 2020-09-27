import 'package:rhoshop/mock/models/category.dart';

class Product {
  String id;
  String defaultName;
  String localizedName;
  String defaultDescription;
  String localizedDescription;
  Category category;
  String imgUrl;
  double price;
  double oldPrice;
  double rating;
  double reviewsCount;

  String name;
  String description;

  Product(
      this.id,
      this.defaultName,
      this.localizedName,
      this.defaultDescription,
      this.localizedDescription,
      this.category,
      this.imgUrl,
      this.price,
      this.oldPrice,
      this.rating,
      this.reviewsCount)
      : name = defaultName,
        description = defaultDescription;
}
