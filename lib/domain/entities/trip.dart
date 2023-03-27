class Trip {
  String? id;
  String? client;
  String? vehicle;
  String? tripStart;
  String? tripEnd;
  String? startDate;
  String? endDate;
  String? tripStatus;
  int? statusId;
  double? totalDistance;
  String? driver;
  String? createdAt;
  double? fromLatitude;
  double? fromLongitude;
  double? toLatitude;
  double? toLongitude;
  String? driveId;
  String? clientId;
  String? dateCompleted;

  Trip({
    this.id,
    this.client,
    this.vehicle,
    this.tripStart,
    this.tripEnd,
    this.startDate,
    this.endDate,
    this.tripStatus,
    this.statusId,
    this.totalDistance,
    this.driver,
    this.createdAt,
    this.fromLatitude,
    this.fromLongitude,
    this.toLatitude,
    this.toLongitude,
    this.clientId,
    this.driveId,
    this.dateCompleted,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? '',
      client: json['client'] ?? '',
      vehicle: json['vehicle'] ?? '',
      tripStart: json['t_trip_start'] ?? '',
      tripEnd: json['t_trip_end'] ?? '',
      startDate: json['trip_start_date'] ?? '',
      endDate: json['trip_end_date'] ?? '',
      tripStatus: json['trip_status'] ?? '',
      totalDistance: (json['t_total_distance'] is int)
          ? double.tryParse(json['t_total_distance'].toString() + ".00")
          : json['t_total_distance'] ?? 0.0,
      driver: json['driver'] ?? '',
      createdAt: json['created_at'] ?? '',
      driveId: json['driver_id'] ?? '',
      clientId: json['client_id'] ?? '',
      fromLatitude: json['from_latitude'] ?? 0.0,
      fromLongitude: json['from_longitude'] ?? 0.0,
      toLatitude: json['to_latitude'] ?? 0.0,
      toLongitude: json['to_longitude'] ?? 0.0,
      statusId: json['status_id'] ?? 0,
      dateCompleted: json['date_completed'] ?? '',
    );
  }
}

class TripModel {
  int? currentPage;
  int? lastPage;
  List<Trip>? trips;

  TripModel({this.trips, this.lastPage, this.currentPage});

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      lastPage: json['last_page'],
      currentPage: json['current_page'] ?? 0,
      trips: (json['data'] as List).map((data) => Trip.fromJson(data)).toList(),
    );
  }
}
