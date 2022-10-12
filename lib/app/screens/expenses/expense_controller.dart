import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/data/repository/expense/data_expense_repository.dart';

import '../../../domain/entities/expense.dart';
import '../../utils/constant.dart';
import 'expense_presenter.dart';

class ExpenseController extends Controller {
  List<Expense>? _expense;
  int? _lastPage;
  int? get lastPage => _lastPage;
  int _page = 0;
  /* */
  final ScrollController _scrollController = ScrollController();
  /* static ~ total amount */
  double _amount = 0;

  ScrollController? get scrollController => _scrollController;
  List<Expense>? get expense => _expense;
  double get amount => _amount;

  final ExpensePresenter presenter;

  ExpenseController(DataExpenseRepository repository)
      : presenter = ExpensePresenter(repository);
  @override
  void initListeners() {
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
      print("trip on complete");
    };
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
