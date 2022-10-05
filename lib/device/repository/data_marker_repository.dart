import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:wtp_app/domain/repositories/direction/marker_repository.dart';

import '../../data/data_constants.dart';

class DataMarkerRepository extends MarkerRepository {
  @override
  Future addMarker(String bookingId, double latitude, double longitude) async {
    EasyLoading.show(status: 'Loading...');
    Map<String, dynamic> body = {
      'booking_id': bookingId,
      'latitude': latitude,
      'longitude': longitude,
    };
    final res = await http.post(Uri.parse("$siteURL/marker/marker"),
        headers: await getHeader1(), body: jsonEncode(body));

    if (res.statusCode != 201) {
      throw Error();
    }
  }
}
