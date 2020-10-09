class UpdateUserDto {
  String name;
  String password;

  UpdateUserDto({this.name, this.password});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (name != null) {
      json['name'] = name;
    }
    if (password != null) {
      json['password'] = password;
    }

    return json;
  }
}
