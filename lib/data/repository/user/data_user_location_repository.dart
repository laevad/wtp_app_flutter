import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/repositories/user/user_location_repository.dart';
import '../../data_constants.dart';
import '../helpers/auth/is_auth.dart';

class DataUserLocationRepository extends UserLocationRepository {
  @override
  Future addLocation(double latitude, double longitude, int statusId) async {
    Map<String, dynamic> body1 = {
      'user_id': await IsAuth.getData("id"),
      'longitude': longitude,
      'latitude': latitude,
      'status_id': statusId,
    };
    await http.post(Uri.parse("${await IsAuth.getData('url')}/user/location"),
        headers: await getHeader1(), body: jsonEncode(body1));
  }

  @override
  Future updateStatus(String bookingId, int statusId) async {
    Map<String, dynamic> body = {
      'booking_id': bookingId,
      'status_id': statusId
    };
    String url = "${await IsAuth.getData('url')}/trip/status";
    await http.post(Uri.parse(url),
        headers: await getHeader1(), body: jsonEncode(body));

    if (statusId == 2) {
      Map<String, dynamic> body = {
        'booking_id': bookingId,
        'driver_id': await IsAuth.getData('id')
      };
      String url = "${await IsAuth.getData('url')}/trip/trip-complete";
      await http.post(Uri.parse(url),
          headers: await getHeader1(), body: jsonEncode(body));
    }
  }
}
