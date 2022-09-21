import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/entities/auth_token.dart';
import '../../../domain/repositories/login_details/auth_repository.dart';
import '../../constants.dart';
import '../helpers/auth/is_auth.dart';

class DataAuthRepository extends AuthRepository {
  @override
  Future<AuthToken> getAuthToken(String email, String pass) async {
    Map<String, dynamic> body = {"email": email, 'password': pass};
    var response =
        await http.post(Uri.parse("$siteURL/auth/login"), body: body);
    if (response.statusCode == 200 || response.statusCode == 401) {
      AuthToken authToken = AuthToken.fromJson(jsonDecode(response.body));
      await IsAuth.setToken(key: 'token', value: authToken.token!);

      return AuthToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return await IsAuth.getData('token') != null ? true : false;
  }
}
