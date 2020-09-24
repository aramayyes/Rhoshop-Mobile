import 'dart:math';

import 'package:rhoshop/mock/models/category.dart';

final random = Random();

final _categories = <Category>[
  Category(
    'Tops',
    'assets/mock/categories/tops.png',
    'Tops',
  ),
  Category(
    'Underwear',
    'assets/mock/categories/underwear.png',
    'Underwear',
  ),
  Category(
    'Sweaters',
    'assets/mock/categories/sweaters.png',
    'Sweaters',
  ),
  Category(
    'Dresses',
    'assets/mock/categories/dresses.png',
    'Dresses',
  ),
  Category(
    'Jeans',
    'assets/mock/categories/jeans.png',
    'Jeans',
  ),
  Category(
    'Leggings',
    'assets/mock/categories/leggings.png',
    'Leggings',
  ),
  Category(
    'Shorts',
    'assets/mock/categories/shorts.png',
    'Shorts',
  ),
];

Future<List<Category>> fetchCategories() async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(2000),
    ),
  );
  return _categories;
}
