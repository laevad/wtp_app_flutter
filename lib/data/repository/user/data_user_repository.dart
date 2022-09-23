import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/data/repository/helpers/auth/is_auth.dart';
import 'package:wtp_app/domain/entities/user.dart';
import 'package:wtp_app/domain/repositories/login_details/user_repository.dart';

import '../../data_constants.dart';

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

  @override
  Future updateProfile(String name, String email, String currPass,
      String newPass, String conPass, String image) async {
    Map<String, String> body = {
      'name': name,
      'email': email,
      'avatar': image,
      'current_password': currPass,
      "new_password": newPass,
      "password_confirmation": conPass,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer ${await IsAuth.getData("token")}',
      'Accept': 'application/json'
    };
    var request =
        http.MultipartRequest('post', Uri.parse("$siteURL/user/update"))
          ..fields.addAll(body)
          ..headers.addAll(headers);
    // ..files.add(await http.MultipartFile.fromPath('image', image));
    final response = await request.send();
    print("Result: ${response.statusCode}");
    // await response.stream.bytesToString()
    if (response.statusCode == 422) {
      // print(await response.stream.bytesToString());
      return User.fromJsonUpdate(
          jsonDecode(await response.stream.bytesToString()));
    }
  }
}
