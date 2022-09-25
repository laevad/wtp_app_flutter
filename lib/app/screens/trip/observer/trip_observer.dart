import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/usecase/trip/get_all_trip_usecase.dart';

import '../trip_presenter.dart';

class GetAllTripUseCaseObserver extends Observer<GetAllTripUseCaseResponse> {
  final TripPresenter presenter;

  GetAllTripUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getTripOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getTripOnError!(e);
  }

  @override
  void onNext(response) {
    presenter.getTripOnNext!(response!.trip);
  }
}
