import 'dart:math';

import 'package:rhoshop/mock/models/category.dart';
import 'package:rhoshop/mock/models/norification.dart';
import 'package:rhoshop/mock/models/product.dart';

final random = Random();
const maxLoadingDuration = 1400;

Future<List<Category>> fetchCategories() async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(maxLoadingDuration),
    ),
  );
  return _categories;
}

Future<List<Product>> fetchProductsByCategory(String categoryId) async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(maxLoadingDuration),
    ),
  );

  final products = _products
      .where(
        (product) => product.category.id == categoryId,
      )
      .toList();
  if (products.length < 10) {
    final productsClone = List<Product>.from(products);
    while (products.length < 16) {
      productsClone.shuffle();
      products.addAll(productsClone);
    }
  }

  return products;
}

Future<List<Product>> fetchNewProducts({count = 7}) async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(maxLoadingDuration),
    ),
  );
  final shuffled = List<Product>.from(_products)..shuffle();
  return shuffled.sublist(0, count);
}

Future<List<Product>> fetchBestSellProducts({count = 7}) async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(maxLoadingDuration),
    ),
  );
  final shuffled = List<Product>.from(_products)..shuffle();
  return shuffled.sublist(0, count);
}

Future<List<Product>> searchProducts(String pattern) async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(maxLoadingDuration),
    ),
  );

  return _products
      .where(
        (product) =>
            product.name.toLowerCase().contains(
                  pattern.toLowerCase(),
                ) ||
            product.localizedName.toLowerCase().contains(
                  pattern.toLowerCase(),
                ),
      )
      .toList()
        ..shuffle();
}

Future<List<AppNotification>> fetchNotifications() async {
  await Future.delayed(
    Duration(
      milliseconds: 100 + random.nextInt(maxLoadingDuration),
    ),
  );
  return _notifications..sort((n1, n2) => n2.date.compareTo(n1.date));
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
  // Category(
  //   'Leggings',
  //   'assets/mock/categories/leggings.png',
  //   'Leggings',
  // ),
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

final topsCategory = _findCategory('Tops');
final underwearCategory = _findCategory('Underwear');
final dressesCategory = _findCategory('Dresses');
final sweatersCategory = _findCategory('Sweaters');
final jeansCategory = _findCategory('Jeans');
final shortsCategory = _findCategory('Shorts');
final _products = <Product>[
  Product(
    '1',
    'Calvin Klein cotton bralette',
    'Calvin Klein бралетт из хлопка',
    'The epitome of minimalist chic, Calvin Klein transfers his love of clean lines seamlessly across the label’s accessory and lingerie collection. Chicly functional purses and bags sit alongside seamless cotton bras, sporty swimwear and luxe loungewear. Look to the fresh Calvin Klein aesthetic and signature CK monogramed prints.',
    'The epitome of minimalist chic, Calvin Klein transfers his love of clean lines seamlessly across the label’s accessory and lingerie collection. Chicly functional purses and bags sit alongside seamless cotton bras, sporty swimwear and luxe loungewear. Look to the fresh Calvin Klein aesthetic and signature CK monogramed prints.',
    underwearCategory,
    'assets/mock/products/underwear/pexels-danielle-pilon.jpg',
    19.99,
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
    'assets/mock/products/underwear/pexels-jonaorle.jpg',
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
  Product(
    '11',
    'Stand-up Collar Top',
    'С присборенным рукавом',
    'Cap-sleeved top in softly draped jersey. Double-layered stand-up collar with gathers at front and opening at back of neck with a button.',
    'Длинное платье из хрустящей нейлоновой ткани. Короткие присборенные рукава с узкими манжетами на обтянутой пуговице. Кокетка и вытачка снизу со сборкой для дополнительного объема. Потайная молния на спине. Без подкладки.',
    dressesCategory,
    'assets/mock/products/dresses/vicky-cheng-unsplash.jpg',
    12.99,
    null,
    4.7,
    85,
  ),
  Product(
    '12',
    'Flounce-trimmed Cotton Dress',
    'Платье из смесового лиоцелла',
    'Cap-sleeved top in softly draped jersey. Double-layered stand-up collar with gathers at front and opening at back of neck with a button.',
    'Платье длиной до икры, без рукавов, из мягко драпирующейся ткани из смесового лиоцелла Tencel™. Высокий крой спереди, узкие бретели и обшитая тканью резинка сзади. Трикотажная подкладка из хлопка.',
    dressesCategory,
    'assets/mock/products/dresses/pexels-bruno-salvadori.jpg',
    49.99,
    99.0,
    4,
    113,
  ),
  Product(
    '13',
    'A-line Dress',
    'Платье на запахе',
    'Short, A-line dress in faux leather. Large, ruffle-trimmed collar, buttons at front, short, voluminous puff sleeves, and narrow cuffs with button. Unlined.',
    'Короткое платье из ткани с v-образным вырезом горловины, запахом спереди и отрезной талией с металлической пуговицей сбоку. Длинный рукав с широким манжетом на металлической пуговице. Подкладка.',
    dressesCategory,
    'assets/mock/products/dresses/pexels-mihai-stefan.jpg',
    39.99,
    null,
    4.5,
    99,
  ),
  Product(
    '14',
    'Long-sleeved Bodycon Dress',
    'Хлопковое платье-рубашка',
    'Short, fitted dress in cotton-blend jersey. Round neckline and long sleeves.',
    'Короткое прямое платье-футболка из плотного хлопкового трикотажа с круглым вырезом горловины, обработанным рельефной трикотажной резинкой. Без подкладки.',
    dressesCategory,
    'assets/mock/products/dresses/pexels-evg-culture.jpg',
    12.99,
    null,
    4.2,
    117,
  ),
  Product(
    '15',
    'Chiffon Dress',
    'Плиссированное платье',
    'Short, A-line dress in crinkled chiffon. Band collar, covered buttons at top, long puff sleeves, and narrow cuffs with a covered button. Seam at waist and tiered skirt. V-neck liner dress in jersey made from recycled polyester with narrow shoulder straps.',
    'Studio Collection. Воздушное плиссированное платье из переработанного полиэстера. Треугольный вырез горловины и узкие бретели, а также поперечные перемычки сзади. Широкий силуэт и вытачки с эластичными швами и сборкой. Без подкладки.',
    dressesCategory,
    'assets/mock/products/dresses/pexels-maksim-goncharenok.jpg',
    29.99,
    null,
    4.0,
    74,
  ),
  Product(
    '16',
    'Chenille Sweater',
    'Вязаный джемпер',
    'Sweater in soft, rib-knit chenille. Round neckline, heavily dropped shoulders, and long sleeves. Rounded hem, slightly longer at back.',
    'Джемпер рельефной вязки из мягкой пряжи с добавлением шерсти. Низкий ворот и длинные широкие рукава реглан с формованными швами. Трикотажная резинка снизу на рукавах и по нижнему краю. Полиэстер в составе джемпера - переработанный.',
    sweatersCategory,
    'assets/mock/products/sweaters/pexels-flora-westbrook.jpg',
    29.99,
    null,
    4.8,
    144,
  ),
  Product(
    '17',
    'Cropped Turtleneck Sweater',
    'Джемпер поло',
    'Boxy turtleneck sweater in a soft rib knit. Dropped shoulders and long, slightly wider sleeves with ribbed cuffs.',
    'Свободный джемпер из мягкой пряжи с добавлением шерсти. Длинные рукава с заниженной линией плеча. Рельефная обвязка снизу на рукавах и по нижнему краю. Скругленный низ. Спинка слегка удлинена. Полиэстер в составе джемпера - переработанный.',
    sweatersCategory,
    'assets/mock/products/sweaters/pexels-daria-shevtsova.jpg',
    17.99,
    null,
    4.5,
    97,
  ),
  Product(
    '18',
    'Oversized Sweater',
    'Джемпер оверсайз',
    'Oversized sweater in soft, knit fabric with wool content. Dropped shoulders, long sleeves, and ribbing at neckline, cuffs, and hem. Longer at back. Polyester content is recycled.',
    'Вязаный джемпер оверсайз из мягкой пряжи с добавлением шерсти. Заниженная линия плеча и длинные рукава. Рельефная обвязка по горловине, низу рукавов и нижнему краю. Скругленный нижний край. Спинка удлинена. Полиэстер в составе джемпера - вторичной переработки.',
    sweatersCategory,
    'assets/mock/products/sweaters/pexels-elina-sazonova.jpg',
    34.99,
    null,
    4.0,
    38,
  ),
  Product(
    '19',
    'Fine-knit Sweater',
    'Вязаный джемпер',
    'Fine-knit, crew-neck sweater in soft, viscose-blend fabric. Long sleeves, short slits at sides, and ribbing at neckline, cuffs, and hem. Slightly longer at back.',
    'Джемпер тонкой вязки из мягкой смесовой вискозы. Круглый вырез горловины, длинные рукава и рельефная трикотажная резинка по горловине, низу рукавов и нижнему краю. Короткие разрезы по бокам и удлиненная спинка.',
    sweatersCategory,
    'assets/mock/products/sweaters/pexels-wesley-carvalho.jpg',
    14.99,
    null,
    4.9,
    113,
  ),
  Product(
    '20',
    'Knit Mock-turtleneck Sweater',
    'Свитер из кашемира',
    'Soft knit sweater with a mock turtleneck and long raglan sleeves.',
    'Свободный свитер тонкой вязки из мягкого кашемира. Заниженная линия плеча и длинные широкие рукава. Рельефная обвязка горловины, низа рукавов и нижнего края.',
    sweatersCategory,
    'assets/mock/products/sweaters/roman-holoschchuk-unsplash.jpg',
    87.99,
    null,
    5.0,
    238,
  ),
  //
  Product(
    '21',
    'Skinny Regular Jeans',
    'Джинсы Skinny Regular',
    '5-pocket jeans in washed stretch denim with a regular waist, zip fly with button, and skinny legs.',
    'Джинсы с пятью карманами из стираного денима стретч. Высокая талия и узкие штанины. Застежка на молнию.',
    jeansCategory,
    'assets/mock/products/jeans/tamara-bellis-unsplash.jpg',
    22.99,
    null,
    4.4,
    126,
  ),
  Product(
    '22',
    'Straight High Ankle Jeans',
    'Джинсы Straight High Ankle',
    '5-pocket, ankle-length jeans in washed stretch denim. High waist, zip fly with button, and straight legs.',
    'Укороченные джинсы с пятью карманами из стираного денима с очень высокой талией и узкими штанинами. В состав джинсов входит переработанный хлопок.',
    jeansCategory,
    'assets/mock/products/jeans/oz-seyrek-unsplash.jpg',
    17.99,
    null,
    4.0,
    34,
  ),
  Product(
    '23',
    'Mom High Ankle Jeans',
    'Джинсы Mom High Ankle',
    '5-pocket, ankle-length jeans in washed denim in a slightly looser fit. Extra-high waist, zip fly and button and gently tapered legs.',
    'Прямые узкие укороченные джинсы с пятью карманами из эластичного стираного денима. Высокая талия. Застежка на пуговицу.',
    jeansCategory,
    'assets/mock/products/jeans/tomiko-tan-unsplash.jpg',
    29.99,
    null,
    4.6,
    165,
  ),
  Product(
    '24',
    'Straight Regular Jeans',
    'Джинсы Straight Regular',
    '5-pocket jeans in washed denim with a regular waist and zip fly with button. Straight-cut, extra-long legs with raw-edge hems.',
    'Прямые, очень длинные джинсы с пятью карманами из стираного денима и необработанным низом штанин. Талия стандартной высоты. Молния и пуговица на талии.',
    jeansCategory,
    'assets/mock/products/jeans/pexels-heitor-verdi.jpg',
    49.99,
    null,
    4.2,
    36,
  ),
  Product(
    '25',
    'Skinny Regular Ankle Jeans',
    'Джинсы Skinny Regular Ankle',
    '5-pocket, jeans in washed, stretch denim. Regular waist, zip fly with button, and skinny, ankle-length legs. Made with Lycra® Beauty technology to retain shape of jeans and provide a sculpting effect with optimal comfort.',
    'Укороченные джинсы из стираного эластичного денима с талией стандартной высоты. Ложные передние карманы, настоящие задние карманы и узкие брючины.',
    jeansCategory,
    'assets/mock/products/jeans/pexels-oleg-magni.jpg',
    59.99,
    null,
    4.3,
    76,
  ),
  Product(
    '26',
    'Shorts High Waist',
    'Шорты Vintage High',
    'Shorts in superstretch twill with a high waist. Zip fly with button, back pockets, and sewn cuffs at hems.',
    'Короткие шорты с пятью карманами из стираного, слегка эластичного хлопкового денима. Высокая талия и необработанный низ.',
    shortsCategory,
    'assets/mock/products/shorts/pexels-gabriel-lima.jpg',
    17.99,
    null,
    4.5,
    242,
  ),
  Product(
    '27',
    'Embrace High Denim Shorts',
    'Шорты Vintage High',
    'Short, 5-pocket shorts in washed denim with distressed details. High waist, zip fly, and skinny legs. Smart stretch function – molds to body for a comfortable and flattering fit. Made partly from recycled cotton.',
    'Шорты с пятью карманами из стираного хлопкового денима с высокой талией и пришитыми отворотами снизу. Застежка на молнию и пуговицу.',
    shortsCategory,
    'assets/mock/products/shorts/engin-akyurt-unsplash.jpg',
    29.99,
    null,
    4.3,
    317,
  ),
  Product(
    '28',
    'Mom Fit Denim Shorts',
    'Джинсовые шорты Mom Fit',
    '5-pocket shorts in washed denim. High waist, zip fly with button, and slightly wider legs.',
    'Шорты с пятью карманами из стираного денима. Высокая талия и довольно широкие штанины. Застежка на молнию и пуговицу.',
    shortsCategory,
    'assets/mock/products/shorts/pexels-thegiansepillo.jpg',
    24.99,
    null,
    4.5,
    100,
  ),
  Product(
    '29',
    'Tailored Shorts',
    'Шорты из смесового льна',
    'Shorts in woven fabric with a high waist. Pleats at front, zip fly with concealed hook-and-eye fasteners, and diagonal side pockets.',
    'Шорты из смесового льна с талией на резинке и кулиске, боковыми карманами, двумя ложными задними карманами и с короткими разрезами внизу штанин.',
    shortsCategory,
    'assets/mock/products/shorts/pexels-gustavo-peres.jpg',
    38.99,
    null,
    4.1,
    77,
  ),
  Product(
    '30',
    'Printed T-shirt',
    'Футболка оверсайз с принтом',
    'Straight-cut T-shirt in cotton jersey with a printed graphic design at front.',
    'Футболка оверсайз из мягкого хлопкового трикотажа с тематическим принтом спереди, обтачкой рельефной резинкой по круглой горловине и слегка заниженной линией плеч.',
    topsCategory,
    'assets/mock/products/tops/anne-peres-unsplash.jpg',
    12.99,
    null,
    4.2,
    31,
  ),
  Product(
    '31',
    'Drawstring Top',
    'Короткий топ из лиоцелла',
    'Short top in crêped jersey. Low-cut V-neck, vertical drawstring at front for a draped effect, and short, wide sleeves.',
    'Укороченный топ из смесового лиоцеллового Tencel™ с легким блеском. Вырез горловины сердечком, на бюсте запах, на спинке широкая сборка мелкими буфами. Модель отрезная под грудью, низ свободный, длинный широкий рукав с потайной резинкой по плечу и узкой сборкой на резинке внизу. Полочка на хлопковой подкладке.',
    topsCategory,
    'assets/mock/products/tops/huseyin-topcu-unsplash.jpg',
    14.99,
    null,
    4.8,
    12,
  ),
  Product(
    '32',
    'Jersey Tank Top',
    'Майка из рельефного трикотажа',
    'Fitted tank top in soft cotton jersey with narrow shoulder straps.',
    'Майка с глубоким вырезом из мягкого рельефного трикотажа из вискозы.',
    topsCategory,
    'assets/mock/products/tops/pexels-marx-ilagan.jpg',
    5.99,
    null,
    4.0,
    89,
  ),
  Product(
    '33',
    'One-shoulder Sweatshirt',
    'Топ на вафельной сборке',
    'One-shoulder sweatshirt in cotton-blend fabric. Wide neckline, long sleeves, and ribbing at neckline, cuffs, and hem. Soft, brushed inside. Polyester content is partly recycled.',
    'Короткий топ из вафельного трикотажа с вырезом горловины каре и короткими рукавами-фонариками с резинкой по плечам и низу. По краю рукава и низу топа обработка оверлоком. Полиэстер в составе топа - частично переработанный.',
    topsCategory,
    'assets/mock/products/tops/pexels-kha-ruxury.jpg',
    17.99,
    null,
    4.6,
    26,
  ),
];

final _notifications = <AppNotification>[
  AppNotification(
    DateTime(2020, 5, 13),
    'Be yourself; everyone else is already taken.',
    "Будь собой, остальные роли заняты",
  ),
  AppNotification(
    DateTime(2020, 4, 14),
    "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.",
    "Только две вещи бесконечны. Вселенная и человеческая глупость. Но я не уверен насчет первого.",
  ),
  AppNotification(
    DateTime(2020, 3, 15),
    "So many books, so little time.",
    "Мне пришлось приложить много усилий, чтобы научиться сдерживать свои чувства и чтобы делать только то, что у меня получается лучше всего, оставляя другим то, чего сам я не могу сделать хорошо.",
  ),
  AppNotification(
    DateTime(2020, 8, 16),
    "I'm selfish, impatient and a little insecure. I make mistakes, I am out of control and at times hard to handle. But if you can't handle me at my worst, then you sure as hell don't deserve me at my best.",
    "Я эгоистичная, нетерпеливая и немного неуверенная в себе. Я делаю ошибки, выхожу из-под контроля и порой со мной трудно справиться. Но если вы не можете общаться со мной, когда я в плохом настроении, то не заслуживаете меня в хорошем.",
  ),
  AppNotification(
    DateTime(2020, 9, 17),
    "You know you're in love when you can't fall asleep because reality is finally better than your dreams.",
    "Если бы я знал, когда видел тебя в последний раз, что это последний раз, я бы постарался запомнить твое лицо, твою походку, все, связанное с тобой. И, если бы я знал, когда в последний раз тебя целовал, что это — последний раз, я бы никогда не остановился.",
  ),
  AppNotification(
    DateTime(2020, 1, 18),
    "You only live once, but if you do it right, once is enough.",
    "Если вы хотите иметь то, что никогда не имели, вам придётся делать то, что никогда не делали.",
  ),
  AppNotification(
    DateTime(2020, 2, 21),
    "No one can make you feel inferior without your consent.",
    "Когда всё заканчивается, боль расставания пропорциональна красоте пережитой любви. Выдержать эту боль трудно, потому что человека сразу же начинают мучить воспоминания.",
  ),
  AppNotification(
    DateTime(2020, 7, 23),
    "Friendship ... is born at the moment when one man says to another \"What! You too? I thought that no one but myself...",
    "Каждому человеку нужно какое-нибудь хобби — якобы с целью «выйти из стресса», — но ты-то прекрасно понимаешь, что на самом деле люди попросту пытаются выжить и не сойти с ума.",
  ),
  AppNotification(
    DateTime(2020, 9, 24),
    "Always forgive your enemies; nothing annoys them so much.",
    "Я знаю, что ты боишься разочаровать меня, но я хочу тебя успокоить, потому что мои ожидания относительно тебя и так невысоки!",
  ),
  AppNotification(
    DateTime(2020, 6, 26),
    "Live as if you were to die tomorrow. Learn as if you were to live forever.",
    "Разговоры... Странная это все таки вещь. Можно обменяться миллионом слов и... не сказать главного. А можно молча смотреть в глаза и... поведать обо всем.",
  ),
];
