import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/map_marker.dart';
import '../../domain/repositories/direction/marker_repository.dart';

import '../../data/data_constants.dart';
import '../../data/repository/helpers/auth/is_auth.dart';

class DataMarkerRepository extends MarkerRepository {
  @override
  Future addMarker(String bookingId, double latitude, double longitude) async {
    EasyLoading.show(status: 'Loading...');
    Map<String, dynamic> body = {
      'booking_id': bookingId,
      'latitude': latitude,
      'longitude': longitude,
    };
    final res = await http.post(
        Uri.parse("${await IsAuth.getData('url')}/marker/marker"),
        headers: await getHeader1(),
        body: jsonEncode(body));

    if (res.statusCode != 201) {
      throw Error();
    }
  }

  @override
  Future getMarkers(String bookingId) async {
    Map<String, dynamic> body = {
      'booking_id': bookingId,
    };
    final res = await http.post(
        Uri.parse("${await IsAuth.getData('url')}/marker/get-marker"),
        headers: await getHeader1(),
        body: jsonEncode(body));

    return MapMarkerModel.fromJson(jsonDecode(res.body));
  }
}
