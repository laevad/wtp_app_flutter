import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/expense/get_expense_type_usecase.dart';
import '../expense_presenter.dart';

class GetExpenseTypeUseCaseObserver
    extends Observer<GetExpenseTypeUseCaseResponse> {
  final ExpensePresenter presenter;

  GetExpenseTypeUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getExpenseTypeOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getExpenseTypeOnError!(e);
  }

  @override
  void onNext(GetExpenseTypeUseCaseResponse? response) {
    presenter.getExpenseOnTypeNext!(response!.typeModel);
  }
}
