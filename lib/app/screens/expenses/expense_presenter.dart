import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/expenses/observer/get_expense_observer.dart';
import 'package:wtp_app/data/repository/expense/data_expense_repository.dart';
import 'package:wtp_app/domain/usecase/expense/get_all_expense_usecase.dart';
import 'package:wtp_app/domain/usecase/expense/get_expense_type_usecase.dart';

import 'observer/get_expense_type_observer.dart';

class ExpensePresenter extends Presenter {
  Function? getExpenseOnComplete;
  Function? getExpenseOnError;
  Function? getExpenseOnNext;

  Function? getExpenseTypeOnComplete;
  Function? getExpenseTypeOnError;
  Function? getExpenseOnTypeNext;

  final GetAllExpenseUseCase getAllExpenseUseCase;
  final GetExpenseTypeUseCase getExpenseTypeUseCase;

  ExpensePresenter(DataExpenseRepository repository)
      : getAllExpenseUseCase = GetAllExpenseUseCase(repository),
        getExpenseTypeUseCase = GetExpenseTypeUseCase(repository);

  @override
  void dispose() {
    getAllExpenseUseCase.dispose();
    getExpenseTypeUseCase.dispose();
  }

  getExpense(int page) {
    return getAllExpenseUseCase.execute(
      GetAllExpenseUseCaseObserver(this),
      GetAllExpenseUseCaseParams(page),
    );
  }

  getExpenseType() {
    return getExpenseTypeUseCase.execute(GetExpenseTypeUseCaseObserver(this));
  }
}
