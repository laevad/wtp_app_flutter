class AuthToken {
  String? token;
  AuthToken({this.token});

  factory AuthToken.fromJson(Map<String, dynamic> response) {
    return AuthToken(token: response['access_token']);
  }
}
