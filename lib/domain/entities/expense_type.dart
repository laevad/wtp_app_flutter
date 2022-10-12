class ExpenseType {
  final String? name;

  ExpenseType({this.name});

  factory ExpenseType.fromJson(Map<String, dynamic> json) {
    return ExpenseType(name: json['name']);
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
