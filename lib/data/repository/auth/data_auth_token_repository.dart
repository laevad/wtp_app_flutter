import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/entities/auth_token.dart';
import '../../../domain/repositories/login_details/auth_repository.dart';
import '../helpers/auth/is_auth.dart';

class DataAuthRepository extends AuthRepository {
  @override
  Future<AuthToken> getAuthToken(String email, String pass) async {
    Map<String, dynamic> body = {"email": email, 'password': pass};
    var response = await http.post(
        Uri.parse("${await IsAuth.getData('url')}/auth/login"),
        body: body);
    if (response.statusCode == 422) {
      return AuthToken.fromJsonErrorMsg(
        jsonDecode(response.body),
        response.statusCode,
      );
    }
    if (response.statusCode == 401) {
      return AuthToken.fromJsonInvalidMsg(
        jsonDecode(response.body),
        response.statusCode,
      );
    }
    if (response.statusCode == 200) {
      AuthToken authToken =
          AuthToken.fromJson(jsonDecode(response.body), response.statusCode);
      await IsAuth.setToken(key: 'token', value: authToken.token!);
      await IsAuth.setToken(key: 'id', value: authToken.id!);
      await IsAuth.setToken(
          key: 'url', value: 'https://wtp-web.herokuapp.com/api');
      return AuthToken.fromJson(jsonDecode(response.body), response.statusCode);
    } else {
      throw Exception;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return await IsAuth.getData('token') != null ? true : false;
  }
}
