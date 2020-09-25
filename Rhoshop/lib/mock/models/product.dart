import 'package:rhoshop/mock/models/category.dart';

class Product {
  String id;
  String name;
  String localizedName;
  String description;
  String localizedDescription;
  Category category;
  String imgUrl;
  double price;
  double oldPrice;
  double rating;
  double reviewsCount;

  Product(
      this.id,
      this.name,
      this.localizedName,
      this.description,
      this.localizedDescription,
      this.category,
      this.imgUrl,
      this.price,
      this.oldPrice,
      this.rating,
      this.reviewsCount);
}
