import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/app/screens/add_expense/add_expense_view.dart';
import 'package:wtp_app/data/repository/expense/data_expense_repository.dart';
import 'package:wtp_app/domain/entities/trip_start_end.dart';

import '../../../domain/entities/expense.dart';
import '../../../domain/entities/expense_type.dart';
import '../../utils/constant.dart';
import 'expense_presenter.dart';

class ExpenseController extends Controller {
  List<Expense>? _expense;
  List<ExpenseType>? _expenseType;
  List<TripStartEnd>? _tripStartEnd;

  Expense? _expenseError;

  int? _lastPage;
  int? _statusCode;
  int _page = 0;
  /* */
  final ScrollController _scrollController = ScrollController();
  /* static ~ total amount */
  double _amount = 0;

  /* getter area */
  ScrollController? get scrollController => _scrollController;
  List<Expense>? get expense => _expense;
  List<ExpenseType>? get expenseType => _expenseType;
  List<TripStartEnd>? get tripStartEnd => _tripStartEnd;
  double get amount => _amount;

  int? get lastPage => _lastPage;
  int? get statusCode => _statusCode;

  final ExpensePresenter presenter;

  ExpenseController(DataExpenseRepository repository)
      : presenter = ExpensePresenter(repository);
  @override
  void initListeners() {
    presenter.getExpenseType();
    presenter.getTripStartEnd();
    Constant.configLoading();
    if (_page == 0) {
      print(_page);
      EasyLoading.show(status: 'loading please wait...');
      presenter.getExpense(++_page);
      refreshUI();
    }

    /* */
    presenter.getExpenseOnNext = (ExpenseModel expense) {
      if (expense.expense != null) {
        for (var i = 0; i < expense.expense!.length; i++) {
          _amount = amount + (expense.expense![i].amount as double);
        }
      }
      if (_expense == null) {
        EasyLoading.show(status: "loading please wait...");
      }
      if (_page == 1) {
        _expense = expense.expense!;
      } else {
        _expense = _expense! + expense.expense!;
      }
      _lastPage = expense.lastPage;
      print("expense on next");
      refreshUI();
    };
    presenter.getExpenseOnError = (e) {
      print("expense on Error: ${e.toString()}");
      EasyLoading.dismiss();
    };
    presenter.getExpenseOnComplete = () async {
      _scrollController.addListener(() {
        if (_page < (lastPage!.toInt())) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            EasyLoading.show(status: "loading please wait...");
            presenter.getExpense(++_page);
            refreshUI();
          }
        }
      });
      EasyLoading.dismiss();
      print("Expense on complete");
    };

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
      EasyLoading.dismiss();
      print("trip s e on complete");
      refreshUI();
    };
    presenter.getTripStartEndOnError = (e) {
      print("trip on error: ${e.toString()}");
      EasyLoading.dismiss();
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

  void addExpenseView() {
    Navigator.pushNamed(getContext(), AddExpenseView.routeName).then((value) {
      EasyLoading.show(status: "Loading..");
      _expense = [];
      _amount = 0;
      presenter.getExpense(1);
      _page = 1;
    });
  }
}
