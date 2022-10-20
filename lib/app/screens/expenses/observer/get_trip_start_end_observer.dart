import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../expense_presenter.dart';
import '../../../../domain/usecase/expense/get_trip_start_end_usecase.dart';

class GetTripStartEndUseCaseObserver
    extends Observer<GetTripStartEndUseCaseResponse> {
  final ExpensePresenter presenter;

  GetTripStartEndUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getTripStartEndOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getTripStartEndOnError!(e);
  }

  @override
  void onNext(GetTripStartEndUseCaseResponse? response) {
    presenter.getTripStartEndOnNext!(response!.tripStartEndModel);
  }
}
