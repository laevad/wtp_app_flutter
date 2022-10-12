import 'package:wtp_app/domain/entities/expense.dart';

abstract class ExpenseRepository {
  Future<ExpenseModel> getAllIncentive(int page);
}
