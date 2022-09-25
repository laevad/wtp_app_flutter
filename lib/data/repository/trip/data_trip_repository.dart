import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/domain/entities/trip.dart';
import 'package:wtp_app/domain/repositories/trip/trip_repository.dart';

import '../../data_constants.dart';
import '../helpers/auth/is_auth.dart';

class DataTripRepository extends TripRepository {
  late List<TripModel> trips;
  @override
  Future<TripModel> getAllTrip(int page) async {
    String url = "$siteURL/trip/trip?page=$page";
    print(url);
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer ${await IsAuth.getData("token")}',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      return TripModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load");
  }
}
