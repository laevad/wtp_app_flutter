import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/data/repository/expense/data_expense_repository.dart';

import '../../../domain/entities/expense.dart';
import '../../../domain/entities/expense_type.dart';
import '../../utils/constant.dart';
import 'expense_presenter.dart';

class ExpenseController extends Controller {
  List<Expense>? _expense;
  List<ExpenseType>? _expenseType;
  int? _lastPage;
  int? get lastPage => _lastPage;
  int _page = 0;
  /* */
  final ScrollController _scrollController = ScrollController();
  /* static ~ total amount */
  double _amount = 0;

  ScrollController? get scrollController => _scrollController;
  List<Expense>? get expense => _expense;
  List<ExpenseType>? get expenseType => _expenseType;
  double get amount => _amount;

  //text controller
  TextEditingController descriptionTextController = TextEditingController();

  final ExpensePresenter presenter;

  ExpenseController(DataExpenseRepository repository)
      : presenter = ExpensePresenter(repository);
  @override
  void initListeners() {
    presenter.getExpenseType();
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
  }

  @override
  void onDisposed() {
    presenter.dispose();
    descriptionTextController.dispose();
    super.onDisposed();
  }

  String? _selectedExpenseType;
  String? _selectedExpense;

  showModalBottom({
    required String title,
    required TextEditingController descriptionTextController,
  }) {
    return showModalBottomSheet(
      context: getContext(),
      isScrollControlled: true,
      builder: (BuildContext context) {
        _selectedExpenseType = null;
        return StatefulBuilder(
          builder: (context, setState) => Container(
            padding: const EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: DropdownButton(
                            underline: const SizedBox(),
                            hint: const Text('Select Expense Type'),
                            value: _selectedExpenseType,
                            isExpanded: true,
                            items: _expenseType!.map(
                              (e) {
                                return DropdownMenuItem(
                                  value: e.id.toString(),
                                  child: Text(e.name.toString()),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() =>
                                  _selectedExpenseType = value.toString());
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.0,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: const TextField(
                            textInputAction: TextInputAction.done,
                            // controller: textEditingController!,
                            decoration: InputDecoration(
                              hintText: 'Amount',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              minLines: 2,
                              maxLines: 5,
                              controller: descriptionTextController,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Constant.lightColorScheme.primary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
