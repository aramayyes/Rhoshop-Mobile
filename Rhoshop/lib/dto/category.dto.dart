import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryDto {
  String id;
  String name;
  String image;
  String thumbnail;

  CategoryDto({this.id, this.name, this.image});

  CategoryDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = '${DotEnv().env['API_IMAGES_URL']}${json['image']}',
        thumbnail = '${DotEnv().env['API_THUMBNAILS_URL']}${json['image']}';
}
