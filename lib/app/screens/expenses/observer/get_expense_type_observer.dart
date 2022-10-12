import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/expenses/expense_presenter.dart';
import 'package:wtp_app/domain/usecase/expense/get_expense_type_usecase.dart';

class GetExpenseTypeUseCase extends Observer<GetExpenseTypeUseCaseResponse> {
  final ExpensePresenter presenter;

  GetExpenseTypeUseCase(this.presenter);

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
