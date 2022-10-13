import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/usecase/expense/add_expense_usecase.dart';

import '../add_expense_presenter.dart';

class AddExpenseUseCaseObserver extends Observer<AddExpenseUseCaseResponse> {
  final AddExpensePresenter presenter;

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
