class UserDto {
  String id;
  String name;
  String phoneNumber;
  String email;

  UserDto({this.id, this.name, this.phoneNumber, this.email});

  UserDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phoneNumber = json['phoneNumber'],
        email = json['email'];
}
