import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/entities/auth_token.dart';
import '../../../domain/repositories/login_details/auth_repository.dart';
import '../../constants.dart';

class DataLoginDetailsRepository extends AuthRepository {
  AuthToken? _userDetails;
  @override
  Future<AuthToken> getAuthToken(String email, String pass) async {
    Map<String, dynamic> body = {"email": email, 'password': pass};
    var response =
        await http.post(Uri.parse("$siteURL/auth/login"), body: body);

    if (response.statusCode == 200 || response.statusCode == 401) {
      return AuthToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error Occurred");
    }
  }
}
