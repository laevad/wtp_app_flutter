class MapMarker {
  String? bookingId;
  double? latitude;
  double? longitude;
  MapMarker({this.bookingId, this.latitude, this.longitude});

  factory MapMarker.fromJson(Map<String, dynamic> json) {
    return MapMarker(
      bookingId: json['booking_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

// class MapMarkerModel {
//   List<MapMarker>? mapMarker;
//
//   factory MapMarkerModel.fromJson(Map<String, dynamic> json) {
//     return MapMarkerModel();
//   }
// }
