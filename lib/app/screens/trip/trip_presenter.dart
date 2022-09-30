import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/usecase/trip/get_all_trip_usecase.dart';

import '../../../data/repository/trip/data_trip_repository.dart';
import '../../../domain/usecase/user/update_trip_status_usecase.dart';
import 'observer/trip_observer.dart';
import 'observer/trip_status_observer.dart';

class TripPresenter extends Presenter {
  Function? getTripOnNext;
  Function? getTripOnError;
  Function? getTripOnComplete;

  Function? updateTripStatusOnNext;
  Function? updateTripStatusOnComplete;
  Function? updateTripStatusOnError;

  final GetAllTripUseCase getAllTripUseCase;
  final UpdateTripStatusUseCase tripStatusUseCase;

  TripPresenter(DataTripRepository tripRepository)
      : getAllTripUseCase = GetAllTripUseCase(tripRepository),
        tripStatusUseCase = UpdateTripStatusUseCase(tripRepository);

  getData(int page) {
    return getAllTripUseCase.execute(
        GetAllTripUseCaseObserver(this), GetAllTripUseCaseParams(page));
  }

  updateStatus(String bookingId, int statusId) {
    tripStatusUseCase.execute(UpdateTripStatusUseCaseObserver(this),
        UpdateTripStatusUseCaseParams(bookingId, statusId));
  }

  @override
  void dispose() {
    getAllTripUseCase.dispose();
    tripStatusUseCase.dispose();
  }
}
