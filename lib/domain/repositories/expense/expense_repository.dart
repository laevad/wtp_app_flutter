import '../../entities/expense.dart';
import '../../entities/expense_type.dart';
import '../../entities/trip_start_end.dart';

abstract class ExpenseRepository {
  Future<ExpenseModel> getAllIncentive(int page);
  Future<ExpenseTypeModel> getExpenseTypeModel();
  Future<TripStartEndModel> getTripStartEndModel();
  Future<ExpenseModel> addExpense(
    String expenseTypeId,
    String bookingId,
    String amount,
    String description,
    String image_path,
  );
}
