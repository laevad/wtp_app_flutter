import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../trip_presenter.dart';
import '../../../../domain/usecase/user/update_trip_status_to_on_going_usecase.dart';

class UpdateTripStatusUseCaseObserver
    extends Observer<UpdateTripStatusUseCaseResponse> {
  final TripPresenter presenter;

  UpdateTripStatusUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.updateTripStatusOnComplete!();
  }

  @override
  void onError(e) {
    presenter.updateTripStatusOnError!(e);
  }

  @override
  void onNext(UpdateTripStatusUseCaseResponse? response) {
    presenter.updateTripStatusOnNext!(response);
  }
}
