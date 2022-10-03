import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class DirectionRepository {
  Future getDirections(
    LatLng origin,
    LatLng destination,
  );
}
