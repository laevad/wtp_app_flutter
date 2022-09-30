import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/domain/repositories/user/user_location_repository.dart';

import '../../data_constants.dart';
import '../helpers/auth/is_auth.dart';

class DataUserLocationRepository extends UserLocationRepository {
  @override
  Future addLocation(double latitude, double longitude) async {
    Map<String, dynamic> body1 = {
      'user_id': await IsAuth.getData("id"),
      'longitude': longitude,
      'latitude': latitude,
    };
    await http.post(Uri.parse("$siteURL/user/location"),
        headers: await getHeader1(), body: jsonEncode(body1));
  }
}
