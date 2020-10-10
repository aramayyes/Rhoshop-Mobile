import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rhoshop/dto/all.dart';

class ProductDto {
  String id;
  String name;
  String description;
  String image;
  String thumbnail;
  CategoryDto category;
  double price;
  double oldPrice;
  double rating;
  int reviewsCount;

  ProductDto({
    this.id,
    this.name,
    this.description,
    this.image,
    this.thumbnail,
    this.category,
    this.price,
    this.oldPrice,
    this.rating,
    this.reviewsCount,
  });

  ProductDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        image = '${DotEnv().env['API_IMAGES_URL']}${json['image']}',
        thumbnail = '${DotEnv().env['API_THUMBNAILS_URL']}${json['image']}',
        category = json.containsKey(['category'])
            ? CategoryDto.fromJson(json['category'])
            : null,
        price = json['price']?.toDouble(),
        oldPrice = json['oldPrice']?.toDouble(),
        rating = json['rating']?.toDouble(),
        reviewsCount = json['reviewsCount'];
}
