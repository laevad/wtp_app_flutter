import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../domain/usecase/trip/get_all_trip_complete_usecase.dart';
import '../../../domain/usecase/trip/get_all_trip_usecase.dart';

import '../../../data/repository/trip/data_trip_repository.dart';
import '../../../domain/usecase/user/update_trip_status_to_on_going_usecase.dart';
import 'observer/trip_c_observer.dart';
import 'observer/trip_observer.dart';
import 'observer/trip_status_observer.dart';

class TripPresenter extends Presenter {
  Function? getTripOnNext;
  Function? getTripOnError;
  Function? getTripOnComplete;

  Function? getTripCOnNext;
  Function? getTripCOnError;
  Function? getTripCOnComplete;

  Function? updateTripStatusOnNext;
  Function? updateTripStatusOnComplete;
  Function? updateTripStatusOnError;

  final GetAllTripUseCase getAllTripUseCase;
  final GetAllTripCompleteUseCase getAllTripCompleteUseCase;
  final UpdateTripStatusToOnGoingUseCase tripStatusUseCase;

  TripPresenter(DataTripRepository tripRepository)
      : getAllTripUseCase = GetAllTripUseCase(tripRepository),
        tripStatusUseCase = UpdateTripStatusToOnGoingUseCase(tripRepository),
        getAllTripCompleteUseCase = GetAllTripCompleteUseCase(tripRepository);

  getData(int page) {
    return getAllTripUseCase.execute(
        GetAllTripUseCaseObserver(this), GetAllTripUseCaseParams(page));
  }

  getDataComplete(int page) {
    return getAllTripCompleteUseCase.execute(
        GetAllTripCompleteUseCaseObserver(this),
        GetAllTripCompleteUseCaseParams(page));
  }

  updateStatus(String bookingId, int statusId) {
    tripStatusUseCase.execute(UpdateTripStatusUseCaseObserver(this),
        UpdateTripStatusUseCaseParams(bookingId, statusId));
  }

  @override
  void dispose() {
    getAllTripUseCase.dispose();
    getAllTripCompleteUseCase.dispose();
    tripStatusUseCase.dispose();
  }
}
