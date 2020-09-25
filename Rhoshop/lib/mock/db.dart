import 'dart:math';

import 'package:rhoshop/mock/models/category.dart';
import 'package:rhoshop/mock/models/product.dart';

final random = Random();

Future<List<Category>> fetchCategories() async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(2000),
    ),
  );
  return _categories;
}

Future<List<Product>> fetchProductsByCategory(String categoryId) async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(2000),
    ),
  );
  return _products.where(
    (product) => product.category.id == categoryId,
  );
}

Future<List<Product>> fetchNewProducts(String categoryId) async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(2000),
    ),
  );
  return List<Product>.from(_products)
    ..shuffle()
    ..sublist(0, 7);
}

Future<List<Product>> fetchBestSellProducts(String categoryId) async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(2000),
    ),
  );
  return List<Product>.from(_products)
    ..shuffle()
    ..sublist(0, 7);
}

Future<List<Product>> searchProducts(String pattern) async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(2000),
    ),
  );

  return _products
      .where(
        (product) => product.name.toLowerCase().contains(
              pattern.toLowerCase(),
            ),
      )
      .toList();
}

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

Category _findCategory(String id) {
  return _categories.singleWhere(
    (category) => category.id == id,
    orElse: () => null,
  );
}

final underwearCategory = _findCategory('Underwear');
final _products = <Product>[
  Product(
    '1',
    'Calvin Klein cotton bralette',
    'Calvin Klein бралетт из хлопка',
    'The epitome of minimalist chic, Calvin Klein transfers his love of clean lines seamlessly across the label’s accessory and lingerie collection. Chicly functional purses and bags sit alongside seamless cotton bras, sporty swimwear and luxe loungewear. Look to the fresh Calvin Klein aesthetic and signature CK monogramed prints.',
    'The epitome of minimalist chic, Calvin Klein transfers his love of clean lines seamlessly across the label’s accessory and lingerie collection. Chicly functional purses and bags sit alongside seamless cotton bras, sporty swimwear and luxe loungewear. Look to the fresh Calvin Klein aesthetic and signature CK monogramed prints.',
    underwearCategory,
    'assets/mock/products/underwear/pexels-danielle-pilon.jpg',
    20.0,
    null,
    4.6,
    84,
  ),
  Product(
    '2',
    'Lace Push-up Bodysuit',
    'Боди из тюля и кружева',
    'Bodysuit in lace and mesh with a push-up bra. Padded underwire cups to maximize bust and cleavage. Adjustable shoulder straps, hook-and-eye fasteners at back, and cutaway coverage at back. Lined gusset with concealed snap fasteners.',
    'Мягкое боди из кружева и тюля с рисунком, с цельнокроеными рукавами и глубоким треугольным вырезом сзади. Ластовица на кнопках.',
    underwearCategory,
    'assets/mock/products/underwear/pexels-chalo-garcia.jpg',
    34.99,
    null,
    5,
    14,
  ),
  Product(
    '3',
    'Seamless Sports Bralette',
    'Бесшовный спортивный бралетт',
    'V-neck sports bralette in fast-drying, functional fabric. Wide shoulder straps, lined cups with removable inserts for shaping, and a racer back. Medium support. Designed with minimum number of seams for a more comfortable fit and added freedom of movement.',
    'Спортивный бюстгальтер с треугольным вырезом из быстросохнущего функционального материала. Чашечки на подкладке, с вынимающимися вкладками, придают бюсту форму. Широкие бретели и спина-борцовка. Средняя степень поддержки. Минимальное количество швов для удобной посадки и максимальной подвижности.',
    underwearCategory,
    'assets/mock/products/underwear/pexels-visionpic.jpg',
    17.99,
    null,
    4.8,
    6,
  ),
  Product(
    '4',
    'Bikini Top',
    'Лиф бикини',
    'Lined, soft-cup bikini top with removable inserts for shaping and good support. Adjustable, ruffle-trimmed shoulder straps and ties at back.',
    'Лиф бикини без бретелей фасона бандо на подкладке, с декоративной окантовкой снизу. Чашечки с вынимающимися вкладками, придают бюсту форму и хорошо поддерживают его. Без застежки.',
    underwearCategory,
    'assets/mock/products/underwear/pexels-ekaterina-bolovtsova.jpg',
    19.99,
    null,
    5,
    39,
  ),
  Product(
    '5',
    'Ribbed Jersey Padded Bra',
    'Хлопковый бюстгальтер',
    'Soft-cup bra in ribbed jersey with wide elastic at lower edge. Adjustable shoulder straps, lined cups with removable inserts for shaping and good support, and hook-and-eye fasteners at back.',
    'Бюстгальтеры из мягкого хлопкового трикотажа. Чашечки без косточек, уплотненные, придают бюсту форму и хорошо поддерживают его. Узкие регулируемые бретели. Застежка на крючки сзади.',
    underwearCategory,
    'assets/mock/products/underwear/katherine-kromberg-unsplash.jpg',
    17.99,
    null,
    4.1,
    273,
  ),
  Product(
    '6',
    'Microfiber Thong Brief',
    'Бюстгальтер без швов',
    'Briefs in microfiber with a low waist, narrow elastic strap at sides, and thong back. Lined gusset.',
    'Бюстгальтер балконет из трикотажа, сшитый с минимальным количеством швов для создания приятного ощущения на коже. Чашечки на косточках, уплотненные, приподнимают бюст и придают ему форму. Отстегивающиеся регулируемые бретели. Широкая застежка на крючки сзади.',
    underwearCategory,
    'assets/mock/products/underwear/max-libertine2-unsplash.jpg',
    12.99,
    null,
    4.4,
    120,
  ),
  Product(
    '7',
    'Lace Push-up Bra',
    'Мягкий кружевной бюстгальтер',
    'Push-up bra in lace with padded, underwire cups to maximize bust and cleavage. Adjustable shoulder straps. Hook-and-eye fasteners at back.',
    'Мягкий бюстгальтер из кружева. Чашечки без косточек, на сетчатой подкладке, придают бюсту естественную форму и слегка поддерживают его. Регулируемые бретели и застежка на крючки сзади, а также широкий кружевной кант снизу.',
    underwearCategory,
    'assets/mock/products/underwear/max-libertine2-unsplash.jpg',
    41.99,
    null,
    4.9,
    67,
  ),
  Product(
    '8',
    'Microfiber Bra',
    'Бюстгальтер из микрофибры',
    'T-shirt bra in microfiber with padded underwire cups for shaping and good support. Adjustable shoulder straps. Hook-and-eye fasteners at back.',
    'Бюстгальтер из микрофибры. Чашечки на косточках, уплотненные, придают бюсту форму и хорошо поддерживают его. Регулируемые лямки и застежка на крючки сзади.',
    underwearCategory,
    'assets/mock/products/underwear/max-libertine-unsplash.jpg',
    18.99,
    null,
    3.9,
    55,
  ),
  Product(
    '9',
    'Padded Lace Bra',
    'Плотный кружевой бюстгальтер',
    'Soft-cup bra in lace. Adjustable shoulder straps, jersey-lined cups with removable inserts for shaping and good support, and wide lower edge. No fasteners.',
    'Мягкий кружевной бюстгальтер. Чашечки без косточек, на подкладке из трикотажа, с вынимающимися вкладками, которые придают бюсту форму, а также хорошо поддерживают его. Широкий кант снизу. Регулируемые бретели. Без застежки.',
    underwearCategory,
    'assets/mock/products/underwear/timofey-urov-unsplash.jpg',
    12.99,
    null,
    5.0,
    195,
  ),
  Product(
    '10',
    'Unpadded Bra',
    'Кружевой бюстгальтер пуш-ап',
    'Unpadded bras in lace. Wide, adjustable shoulder straps, mesh-lined, underwire cups for natural shape and extra-firm support, and hook-and-eye fasteners at back.',
    'Мягкий кружевной бюстгальтер. Уплотненные чашечки без косточек, зрительно увеличивают бюст и создают пышное декольте. Широкий кружевной кант снизу. Регулируемые бретели. Застежка на крючки сзади.',
    underwearCategory,
    'assets/mock/products/underwear/garin-chadwick-unsplash.jpg',
    29.99,
    null,
    4.9,
    103,
  ),
];
