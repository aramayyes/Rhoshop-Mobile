import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryDto {
  String id;
  String name;
  String image;

  CategoryDto({this.id, this.name, this.image});

  CategoryDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = '${DotEnv().env['API_HOST']}${json['image']}';
}
