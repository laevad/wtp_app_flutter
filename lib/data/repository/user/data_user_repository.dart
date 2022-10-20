import 'dart:convert';

import 'package:http/http.dart' as http;
import '../helpers/auth/is_auth.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/login_details/user_repository.dart';

import '../../data_constants.dart';

class DataUserRepository extends UserRepository {
  @override
  Future getUser() async {
    var response = await http.get(
        Uri.parse("${await IsAuth.getData('url')}/auth/me"),
        headers: await getHeader());
    return User.fromJson(jsonDecode(response.body));
  }

  @override
  Future updateProfile(String name, String email, String currPass,
      String newPass, String conPass, String image) async {
    // print("image in data: $image");
    Map<String, String> body = {
      'name': name,
      'email': email,
      'image': image,
      'current_password': currPass,
      "new_password": newPass,
      "password_confirmation": conPass,
    };

    if (image.isNotEmpty) {
      var request = http.MultipartRequest(
          'post', Uri.parse("${await IsAuth.getData('url')}/user/update"))
        ..fields.addAll(body)
        ..headers.addAll(await getHeader())
        ..files.add(await http.MultipartFile.fromPath('image', image));
      final response = await request.send();

      // await response.stream.bytesToString()
      if (response.statusCode == 422) {
        return User.fromJsonUpdate(
            jsonDecode(await response.stream.bytesToString()),
            response.statusCode);
        throw Error();
      }
      return User.fromJsonUpdate(
          jsonDecode(await response.stream.bytesToString()),
          response.statusCode);
    }
    var request = http.MultipartRequest(
        'post', Uri.parse("${await IsAuth.getData('url')}/user/update"))
      ..fields.addAll(body)
      ..headers.addAll(await getHeader1());
    // ..files.add(await http.MultipartFile.fromPath('image', image));
    final response = await request.send();
    print("Result data: ${response.statusCode}");

    return User.fromJsonUpdate(
        jsonDecode(await response.stream.bytesToString()), response.statusCode);
  }
}
