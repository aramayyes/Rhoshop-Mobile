class Category {
  String id;
  String imgUrl;
  String defaultName;
  String localizedName;
  String name;

  Category(this.id, this.imgUrl, this.defaultName, this.localizedName)
      : name = defaultName;
}
