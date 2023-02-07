import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/expense/data_expense_repository.dart';
import '../../../domain/usecase/expense/add_expense_usecase.dart';
import '../../../domain/usecase/expense/get_all_expense_usecase.dart';
import '../../../domain/usecase/expense/get_expense_type_usecase.dart';
import '../../../domain/usecase/expense/get_trip_start_end_usecase.dart';
import 'observer/add_expense_observer.dart';
import 'observer/get_expense_observer.dart';
import 'observer/get_expense_type_observer.dart';
import 'observer/get_trip_start_end_observer.dart';

class ExpensePresenter extends Presenter {
  Function? getExpenseOnComplete;
  Function? getExpenseOnError;
  Function? getExpenseOnNext;

  Function? getExpenseTypeOnComplete;
  Function? getExpenseTypeOnError;
  Function? getExpenseOnTypeNext;

  Function? getTripStartEndOnNext;
  Function? getTripStartEndOnComplete;
  Function? getTripStartEndOnError;

  Function? addExpenseOnComplete;
  Function? addExpenseOnNext;
  Function? addExpenseOnError;

  final GetAllExpenseUseCase getAllExpenseUseCase;
  final GetExpenseTypeUseCase getExpenseTypeUseCase;
  final GetTripStartEndUseCase getTripStartEndUseCase;
  final AddExpenseUseCase addExpenseUseCase;

  ExpensePresenter(DataExpenseRepository repository)
      : getAllExpenseUseCase = GetAllExpenseUseCase(repository),
        getExpenseTypeUseCase = GetExpenseTypeUseCase(repository),
        getTripStartEndUseCase = GetTripStartEndUseCase(repository),
        addExpenseUseCase = AddExpenseUseCase(repository);

  @override
  void dispose() {
    getAllExpenseUseCase.dispose();
    getExpenseTypeUseCase.dispose();
    getTripStartEndUseCase.dispose();
    addExpenseUseCase.dispose();
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

  getTripStartEnd() {
    return getTripStartEndUseCase.execute(GetTripStartEndUseCaseObserver(this));
  }

  addExpense(String expenseTypeId, String bookingId, String amount,
      String description) {
    addExpenseUseCase.execute(
        AddExpenseUseCaseObserver(this),
        AddExpenseUseCaseParams(
            expenseTypeId, bookingId, amount, description, ''));
  }
}
