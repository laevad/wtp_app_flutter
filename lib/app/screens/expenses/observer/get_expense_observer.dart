import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/expense/get_all_expense_usecase.dart';
import '../expense_presenter.dart';

class GetAllExpenseUseCaseObserver
    extends Observer<GetAllExpenseUseCaseResponse> {
  final ExpensePresenter presenter;

  GetAllExpenseUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getExpenseOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getExpenseOnError!(e);
  }

  @override
  void onNext(GetAllExpenseUseCaseResponse? response) {
    presenter.getExpenseOnNext!(response!.expense);
  }
}
