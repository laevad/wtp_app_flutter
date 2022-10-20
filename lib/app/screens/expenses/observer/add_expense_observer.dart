import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/expense/add_expense_usecase.dart';
import '../expense_presenter.dart';

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
