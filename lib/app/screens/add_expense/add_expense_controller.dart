import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/expense/data_expense_repository.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/entities/expense_type.dart';
import '../../../domain/entities/trip_start_end.dart';
import 'add_expense_presenter.dart';

class AddExpenseController extends Controller {
  final AddExpensePresenter presenter;

  List<ExpenseType>? _expenseType;
  List<TripStartEnd>? _tripStartEnd;
  Expense? _expenseError;
  int? _statusCode;

  List<ExpenseType>? get expenseType => _expenseType;
  List<TripStartEnd>? get tripStartEnd => _tripStartEnd;

  Expense? get expenseError => _expenseError;

  AddExpenseController(DataExpenseRepository repository)
      : presenter = AddExpensePresenter(repository);
  @override
  void initListeners() {
    /*------------------------------------------------------------------------*/
    presenter.getExpenseOnTypeNext = (ExpenseTypeModel expenseType) async {
      _expenseType = expenseType.expenseType;
      print("Expense type on next");
      refreshUI();
    };
    presenter.getExpenseTypeOnComplete = () {
      print("Expense type on complete");
      refreshUI();
    };
    presenter.getExpenseTypeOnError = (e) {
      refreshUI();
      print("Expense type on error: ${e.toString()}");
    };
    /*------------------------------------------------------------------------*/
    presenter.getTripStartEndOnNext = (TripStartEndModel trip) {
      _tripStartEnd = trip.tripStartEnd;
      print("trip s e on next");
      refreshUI();
    };
    presenter.getTripStartEndOnComplete = () {
      refreshUI();
      print("trip s e on complete");
    };
    presenter.getTripStartEndOnError = (e) {
      print("trip on error: ${e.toString()}");
      refreshUI();
    };
    /* ---------------------------------------------------------------------- */
    presenter.addExpenseOnNext = (ExpenseModel expenseModel) {
      _expenseError = expenseModel.errors;
      _statusCode = expenseModel.statusCode;
      print(expenseModel.statusCode);
      print("add expense on next");
      refreshUI();
    };
    presenter.addExpenseOnComplete = () {
      print("add expense on complete");
      refreshUI();
    };
    presenter.addExpenseOnError = (e) {
      print("add expense on error: ${e.toString()}");
      refreshUI();
    };
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
