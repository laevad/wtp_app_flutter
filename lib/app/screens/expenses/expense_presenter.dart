import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/expenses/observer/get_expense_observer.dart';
import 'package:wtp_app/data/repository/expense/data_expense_repository.dart';
import 'package:wtp_app/domain/usecase/expense/get_all_expense_usecase.dart';

class ExpensePresenter extends Presenter {
  Function? getExpenseOnComplete;
  Function? getExpenseOnError;
  Function? getExpenseOnNext;

  final GetAllExpenseUseCase getAllExpenseUseCase;

  ExpensePresenter(DataExpenseRepository repository)
      : getAllExpenseUseCase = GetAllExpenseUseCase(repository);

  @override
  void dispose() {
    getAllExpenseUseCase.dispose();
  }

  getExpense(int page) {
    return getAllExpenseUseCase.execute(
      GetAllExpenseUseCaseObserver(this),
      GetAllExpenseUseCaseParams(page),
    );
  }
}
