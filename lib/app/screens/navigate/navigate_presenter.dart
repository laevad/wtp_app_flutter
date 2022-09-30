import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecase/user/add_user_location_usecase.dart';
import '../../../domain/usecase/user/update_trip_status_to_complete_usecase.dart';
import 'observer/add_user_location_observer.dart';
import 'observer/update_trip_status_completed_observer.dart';

class NavigatePresenter extends Presenter {
  /*location*/
  Function? getUserLocationOnNext;
  Function? getUserLocationOnError;
  Function? getUserLocationOnComplete;

  Function? updateTripStatusOnNext;
  Function? updateTripStatusOnComplete;
  Function? updateTripStatusOnError;

  final AddUserLocationUseCase addUserLocationUseCase;
  final UpdateTripStatusToCompleteUseCase tripStatusToCompleteUseCase;

  NavigatePresenter(repository)
      : addUserLocationUseCase = AddUserLocationUseCase(repository),
        tripStatusToCompleteUseCase =
            UpdateTripStatusToCompleteUseCase(repository);

  @override
  void dispose() {
    addUserLocationUseCase.dispose();
    tripStatusToCompleteUseCase.dispose();
  }

  addUserLocation(double latitude, double longitude) {
    addUserLocationUseCase.execute(
        AddUserLocationUseCaseObserver(this),
        AddUserLocationUseCaseParams(
          latitude,
          longitude,
        ));
  }

  updateStatus(String bookingId, int statusId) {
    tripStatusToCompleteUseCase.execute(UpdateTripStatusCompletedObserver(this),
        UpdateTripStatusToCompleteUseCaseParams(bookingId, statusId));
  }
}
