class CreateUserDto {
  String name;
  String phoneNumber;
  String email;
  String password;

  CreateUserDto({this.name, this.phoneNumber, this.email, this.password});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
      };
}
