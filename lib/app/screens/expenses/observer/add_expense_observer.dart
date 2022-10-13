import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/expenses/expense_presenter.dart';
import 'package:wtp_app/domain/usecase/expense/add_expense_usecase.dart';

class AddExpenseUseCaseObserver extends Observer<AddExpenseUseCaseResponse> {
  final ExpensePresenter presenter;

  AddExpenseUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.addExpenseOnComplete!();
  }

  @override
  void onError(e) {
    presenter.addExpenseOnError!(e);
  }

  @override
  void onNext(AddExpenseUseCaseResponse? response) {
    presenter.addExpenseOnNext!(response!.expenseModel);
  }
}
