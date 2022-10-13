import 'package:wtp_app/domain/entities/expense.dart';
import 'package:wtp_app/domain/entities/trip_start_end.dart';

import '../../entities/expense_type.dart';

abstract class ExpenseRepository {
  Future<ExpenseModel> getAllIncentive(int page);
  Future<ExpenseTypeModel> getExpenseTypeModel();
  Future<TripStartEndModel> getTripStartEndModel();
  Future<ExpenseModel> addExpense(
    String expenseTypeId,
    String bookingId,
    String amount,
    String description,
  );
}
