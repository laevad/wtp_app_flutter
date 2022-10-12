import 'package:wtp_app/domain/entities/expense.dart';

import '../../entities/expense_type.dart';

abstract class ExpenseRepository {
  Future<ExpenseModel> getAllIncentive(int page);
  Future<ExpenseTypeModel> getExpenseTypeModel();
}
