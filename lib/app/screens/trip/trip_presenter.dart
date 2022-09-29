import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/usecase/trip/get_all_trip_usecase.dart';

import 'observer/trip_observer.dart';

class TripPresenter extends Presenter {
  Function? getTripOnNext;
  Function? getTripOnError;
  Function? getTripOnComplete;

  final GetAllTripUseCase getAllTripUseCase;

  TripPresenter(tripRepository)
      : getAllTripUseCase = GetAllTripUseCase(tripRepository);

  getData(int page) {
    return getAllTripUseCase.execute(
        GetAllTripUseCaseObserver(this), GetAllTripUseCaseParams(page));
  }

  @override
  void dispose() {
    getAllTripUseCase.dispose();
  }
}
