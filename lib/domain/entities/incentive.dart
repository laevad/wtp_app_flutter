class Incentive {
  String? date;
  double? amount;
  String? note;
  Incentive({this.date, this.amount, this.note});

  factory Incentive.fromJson(Map<String, dynamic> json) {
    return Incentive(
        date: json['date'],
        amount: (json['amount'] as int).toDouble(),
        note: json['note']);
  }
}

class IncentiveModel {
  int? currentPage;
  int? lastPage;
  List<Incentive>? incentive;
  IncentiveModel({this.incentive, this.lastPage, this.currentPage});
  factory IncentiveModel.fromJson(Map<String, dynamic> json) {
    return IncentiveModel(
      lastPage: json['last_page'],
      currentPage: json['current_page'] ?? 0,
      incentive: (json['data'] as List)
          .map((data) => Incentive.fromJson(data))
          .toList(),
    );
  }
}
