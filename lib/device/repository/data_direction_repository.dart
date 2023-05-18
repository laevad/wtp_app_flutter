import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/direction.dart';
import '../../domain/repositories/direction/direction_repository.dart';
import '../utils/direction_constant.dart';

class DataDirectionRepository extends DirectionRepository {
  @override
  Future getDirections(LatLng origin, LatLng destination) async {
    EasyLoading.show(status: 'Loading...');
    var response = await http.get(
      Uri.parse(
        "$baseUrl"
        "origin=${origin.latitude},${origin.longitude}"
        "&"
        "destination=${destination.latitude},${destination.longitude}"
        "&key=AIzaSyAuP2xRkKoSs-46LTPmJklTqcLakm1TP30",
      ),
    );
    // Check if response is successful
    if (response.statusCode == 200) {
      if ((jsonDecode(response.body)['routes']).isEmpty) return null;
      return Directions.fromMap(jsonDecode(response.body));
    }
    return null;
  }
}
