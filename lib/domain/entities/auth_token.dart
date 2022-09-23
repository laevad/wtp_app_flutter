class AuthToken {
  String? token;
  String? emailMsg;
  String? passwordMsg;
  int? statusCode;
  String? invalidCred;
  AuthToken(
      {this.token,
      this.emailMsg,
      this.passwordMsg,
      this.statusCode,
      this.invalidCred});

  factory AuthToken.fromJson(Map<String, dynamic> response, int statusCode) {
    return AuthToken(token: response['access_token'], statusCode: statusCode);
  }

  factory AuthToken.fromJsonErrorMsg(
      Map<String, dynamic> response, int statusCode) {
    return AuthToken(
        emailMsg: response['errors']['email'],
        passwordMsg: response['errors']['password'],
        statusCode: statusCode);
  }
  factory AuthToken.fromJsonInvalidMsg(
      Map<String, dynamic> response, int statusCode) {
    return AuthToken(invalidCred: response['error'], statusCode: statusCode);
  }
}
