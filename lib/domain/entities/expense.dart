class Expense {
  final String? date;
  final String? id;
  final double? amount;
  final String? note;
  final String? expenseType;
  final String? tripStart;
  final String? tripEnd;
  final String? bookingId;
  /*image_path*/
  final String? imagePath;
  /* error */
  final String? expenseTypeError;
  final String? amountError;
  final String? descriptionError;
  final String? bookingError;
  final String? imagePathError;

  Expense({
    this.id,
    this.date,
    this.amount,
    this.note,
    this.imagePath,
    this.expenseType,
    this.tripStart,
    this.tripEnd,
    this.bookingId,
    this.expenseTypeError,
    this.amountError,
    this.descriptionError,
    this.bookingError,
    this.imagePathError,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      date: json['date'],
      amount: json['amount'].runtimeType == int
          ? (json['amount'] as int).toDouble()
          : json['amount'],
      note: json['note'],
      expenseType: json['expense_type'],
      bookingId: json['booking_id'],
      imagePath: json['image_path'],
      tripStart: json['trip_start'],
      tripEnd: json['trip_end'],
    );
  }
  factory Expense.fromJsonError(Map<String, dynamic> json) {
    return Expense(
      amountError: json['amount'],
      descriptionError: json['description'],
      expenseTypeError: json['expense_type_id'],
      /*imageError*/
      imagePathError: json['image_path'],
      bookingError: json['booking_id'],
    );
  }
}

class ExpenseModel {
  int? currentPage;
  int? lastPage;
  List<Expense>? expense;
  Expense? errors;
  int? statusCode;
  ExpenseModel(
      {this.expense,
      this.lastPage,
      this.currentPage,
      this.errors,
      this.statusCode});
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
        lastPage: json['last_page'],
        currentPage: json['current_page'] ?? 0,
        expense: (json['data'] as List)
            .map((data) => Expense.fromJson(data))
            .toList());
  }

  factory ExpenseModel.fromJsonError(
      Map<String, dynamic> json, int statusCode) {
    return ExpenseModel(
      errors: Expense.fromJsonError(json['errors']),
      statusCode: statusCode,
    );
  }
}
