class Expense {
  final String? date;
  final double? amount;
  final String? note;
  final String? expenseType;
  final String? tripStart;
  final String? tripEnd;
  final String? bookingId;
  /* error */
  final String? expenseTypeError;
  final String? amountError;
  final String? descriptionError;
  final String? bookingError;

  Expense({
    this.date,
    this.amount,
    this.note,
    this.expenseType,
    this.tripStart,
    this.tripEnd,
    this.bookingId,
    this.expenseTypeError,
    this.amountError,
    this.descriptionError,
    this.bookingError,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      date: json['date'],
      amount: (json['amount'] as int).toDouble(),
      note: json['note'],
      expenseType: json['expense_type'],
      bookingId: json['booking_id'],
    );
  }
  factory Expense.fromJsonError(Map<String, dynamic> json) {
    return Expense(
      amount: (json['amount'] as int).toDouble(),
      note: json['description'],
      expenseType: json['expense_type_id'],
      bookingError: json['booking_id'],
    );
  }
}

class ExpenseModel {
  int? currentPage;
  int? lastPage;
  List<Expense>? expense;
  Expense? errors;
  ExpenseModel({this.expense, this.lastPage, this.currentPage, this.errors});
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
        lastPage: json['last_page'],
        currentPage: json['current_page'] ?? 0,
        expense: (json['data'] as List)
            .map((data) => Expense.fromJson(data))
            .toList());
  }

  factory ExpenseModel.fromJsonError(Map<String, dynamic> json) {
    return ExpenseModel(errors: Expense.fromJsonError(json['errors']));
  }
}
