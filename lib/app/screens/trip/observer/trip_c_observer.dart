import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/trip/get_all_trip_complete_usecase.dart';
import '../trip_presenter.dart';

class GetAllTripCompleteUseCaseObserver
    extends Observer<GetAllTripCompleteUseCaseResponse> {
  final TripPresenter presenter;

  GetAllTripCompleteUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getTripCOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getTripCOnError!(e);
  }

  @override
  void onNext(response) {
    presenter.getTripCOnNext!(response!.trip);
  }
}
