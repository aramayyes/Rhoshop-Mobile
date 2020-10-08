class SignInDto {
  String email;
  String password;

  SignInDto({this.email, this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
