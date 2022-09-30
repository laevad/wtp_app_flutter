import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/navigate/navigate_presenter.dart';
import 'package:wtp_app/domain/usecase/user/update_trip_status_to_complete_usecase.dart';

class UpdateTripStatusCompletedObserver
    extends Observer<UpdateTripStatusToCompleteUseCaseResponse> {
  final NavigatePresenter presenter;

  UpdateTripStatusCompletedObserver(this.presenter);
  @override
  void onComplete() {
    presenter.updateTripStatusOnComplete!();
  }

  @override
  void onError(e) {
    presenter.updateTripStatusOnError!(e);
  }

  @override
  void onNext(UpdateTripStatusToCompleteUseCaseResponse? response) {
    presenter.updateTripStatusOnNext!(response);
  }
}