class Expense {
  final String? date;
  final double? amount;
  final String? note;
  final String? expenseType;

  Expense({
    this.date,
    this.amount,
    this.note,
    this.expenseType,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      date: json['date'],
      amount: (json['amount'] as int).toDouble(),
      note: json['note'],
      expenseType: json['expense_type'],
    );
  }
}

class ExpenseModel {
  int? currentPage;
  int? lastPage;
  List<Expense>? expense;
  ExpenseModel({this.expense, this.lastPage, this.currentPage});
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
        lastPage: json['last_page'],
        currentPage: json['current_page'] ?? 0,
        expense: (json['data'] as List)
            .map((data) => Expense.fromJson(data))
            .toList());
  }
}
