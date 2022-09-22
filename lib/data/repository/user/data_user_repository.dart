import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/data/repository/helpers/auth/is_auth.dart';
import 'package:wtp_app/domain/entities/user.dart';
import 'package:wtp_app/domain/repositories/login_details/user_repository.dart';

import '../../constants.dart';

class DataUserRepository extends UserRepository {
  @override
  Future getUser() async {
    var response = await http.get(Uri.parse("$siteURL/auth/me"), headers: {
      'Authorization': 'Bearer ${await IsAuth.getData("token")}',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });

    return User.fromJson(jsonDecode(response.body));
  }
}
