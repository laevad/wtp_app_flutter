class Trip {
  String? id;
  String? client;
  String? vehicle;
  String? tripStart;
  String? tripEnd;
  String? startDate;
  String? endDate;
  String? tripStatus;
  int? totalDistance;
  String? driver;
  String? createdAt;

  Trip({
    this.id,
    this.client,
    this.vehicle,
    this.tripStart,
    this.tripEnd,
    this.startDate,
    this.endDate,
    this.tripStatus,
    this.totalDistance,
    this.driver,
    this.createdAt,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      client: json['client'],
      vehicle: json['vehicle'],
      tripStart: json['t_trip_start'],
      tripEnd: json['t_trip_end'],
      startDate: json['trip_start_date'],
      endDate: json['trip_end_date'],
      tripStatus: json['trip_status'],
      totalDistance: json['t_total_distance'],
      driver: json['driver'],
      createdAt: json['created_at'],
    );
  }
}

class TripModel {
  int? totalPage;
  int? perPage;
  int? currentPage;
  int? lastPage;
  List<Trip>? trips;

  TripModel(
      {this.totalPage,
      this.trips,
      this.perPage,
      this.lastPage,
      this.currentPage});

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      totalPage: json['to'],
      perPage: json['per_page'],
      lastPage: json['last_page'],
      currentPage: json['current_page'],
      trips: (json['data'] as List).map((data) => Trip.fromJson(data)).toList(),
    );
  }
}
