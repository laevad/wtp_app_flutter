class MapMarker {
  String? id;
  String? bookingId;
  double? latitude;
  double? longitude;
  MapMarker({this.bookingId, this.latitude, this.longitude, this.id});

  factory MapMarker.fromJson(Map<String, dynamic> json) {
    return MapMarker(
      id: json['id'],
      bookingId: json['booking_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class MapMarkerModel {
  List<MapMarker>? mapMarker;

  MapMarkerModel({this.mapMarker});

  factory MapMarkerModel.fromJson(Map<String, dynamic> json) {
    return MapMarkerModel(
      mapMarker: (json['data'] as List)
          .map((marker) => MapMarker.fromJson(marker))
          .toList(),
    );
  }
}
