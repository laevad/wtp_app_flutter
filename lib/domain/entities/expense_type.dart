class ExpenseType {
  final String? name;
  final int? id;
  ExpenseType({this.name, this.id});

  factory ExpenseType.fromJson(Map<String, dynamic> json) {
    return ExpenseType(name: json['name'], id: json['id']);
  }
}

class ExpenseTypeModel {
  final List<ExpenseType>? expenseType;

  ExpenseTypeModel({this.expenseType});

  factory ExpenseTypeModel.fromJson(Map<String, dynamic> json) {
    return ExpenseTypeModel(
      expenseType: (json['data'] as List)
          .map((data) => ExpenseType.fromJson(data))
          .toList(),
    );
  }
}
