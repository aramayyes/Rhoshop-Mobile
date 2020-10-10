class JwtTokenDto {
  String accessToken;
  String email;

  JwtTokenDto({this.accessToken, this.email});

  JwtTokenDto.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        email = json['email'];
}
