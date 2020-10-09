class FilterProductsDto {
  String category;
  String name;
  List<String> ids;

  FilterProductsDto({this.category, this.name, this.ids});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (category != null) {
      json['category'] = category;
    }
    if (name != null) {
      json['name'] = name;
    }
    if (ids != null) {
      json['ids'] = ids;
    }

    return json;
  }
}
