import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/usecase/trip/get_all_trip_usecase.dart';

import '../../../domain/usecase/user/add_user_location_usecase.dart';
import 'observer/add_user_location_observer.dart';
import 'observer/trip_observer.dart';

class TripPresenter extends Presenter {
  Function? getTripOnNext;
  Function? getTripOnError;
  Function? getTripOnComplete;

  /*location*/
  Function? getUserLocationOnNext;
  Function? getUserLocationOnError;
  Function? getUserLocationOnComplete;

  final GetAllTripUseCase getAllTripUseCase;
  final AddUserLocationUseCase addUserLocationUseCase;

  TripPresenter(tripRepository, repository)
      : getAllTripUseCase = GetAllTripUseCase(tripRepository),
        addUserLocationUseCase = AddUserLocationUseCase(repository);

  getData(int page) {
    return getAllTripUseCase.execute(
        GetAllTripUseCaseObserver(this), GetAllTripUseCaseParams(page));
  }

  addUserLocation(double latitude, double longitude) {
    return addUserLocationUseCase.execute(
        AddUserLocationUseCaseObserver(this),
        AddUserLocationUseCaseParams(
          latitude,
          longitude,
        ));
  }

  @override
  void dispose() {
    addUserLocationUseCase.dispose();
    getAllTripUseCase.dispose();
  }
}
