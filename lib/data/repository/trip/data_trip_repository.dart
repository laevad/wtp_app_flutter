import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/domain/entities/trip.dart';
import 'package:wtp_app/domain/repositories/trip/trip_repository.dart';

import '../../data_constants.dart';

class DataTripRepository extends TripRepository {
  late List<TripModel> trips;
  @override
  Future<TripModel> getAllTrip(int page) async {
    String url = "$siteURL/trip/trip?page=$page";
    var response = await http.get(Uri.parse(url), headers: await getHeader1());

    if (response.statusCode == 200) {
      return TripModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load");
  }

  @override
  Future updateStatus() {
    // TODO: implement onGoing
    throw UnimplementedError();
  }
}
