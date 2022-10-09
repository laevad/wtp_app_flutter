import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/data/repository/helpers/auth/is_auth.dart';
import 'package:wtp_app/domain/entities/trip.dart';
import 'package:wtp_app/domain/repositories/trip/trip_repository.dart';

import '../../data_constants.dart';

class DataTripRepository extends TripRepository {
  late List<TripModel> trips;
  @override
  Future<TripModel> getAllTrip(int page) async {
    String url = "${await IsAuth.getData('url')}/trip/trip?page=$page";
    Map<String, dynamic> body1 = {
      'driver_id': await IsAuth.getData('id'),
      'trip_status_id': '',
    };

    var response = await http.post(
      Uri.parse(url),
      headers: await getHeader1(),
      body: jsonEncode(body1),
    );
    if (response.statusCode == 200) {
      return TripModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load");
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
  }

  @override
  Future<TripModel> getAllTripComplete(int page) async {
    String url = "${await IsAuth.getData('url')}/trip/trip?page=$page";
    Map<String, dynamic> body1 = {
      'driver_id': await IsAuth.getData('id'),
      'trip_status_id': 2,
    };
    var response = await http.post(
      Uri.parse(url),
      headers: await getHeader1(),
      body: jsonEncode(body1),
    );
    if (response.statusCode == 200) {
      return TripModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load");
  }
}
