class TripStartEnd {
  final String? id;
  final String? start;
  final String? end;
  final String? dateCompleted;

  TripStartEnd({
    this.id,
    this.start,
    this.end,
    this.dateCompleted,
  });

  factory TripStartEnd.fromJson(Map<String, dynamic> json) {
    return TripStartEnd(
      id: json['id'],
      start: json['trip_start'],
      end: json['trip_end'],
      dateCompleted: json['date_completed'] ?? '',
    );
  }
}

class TripStartEndModel {
  final List<TripStartEnd>? tripStartEnd;

  TripStartEndModel({this.tripStartEnd});

  factory TripStartEndModel.fromJson(Map<String, dynamic> json) {
    return TripStartEndModel(
      tripStartEnd: (json['data'] as List)
          .map((data) => TripStartEnd.fromJson(data))
          .toList(),
    );
  }
}
