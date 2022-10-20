import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../device/repository/data_marker_repository.dart';

import '../../../data/repository/user/data_user_location_repository.dart';
import '../../../domain/usecase/direction/add_marker_usecase.dart';
import '../../../domain/usecase/direction/get_direction_usercase.dart';
import '../../../domain/usecase/direction/get_marker_usecase.dart';
import '../../../domain/usecase/user/add_user_location_usecase.dart';
import '../../../domain/usecase/user/update_trip_status_to_complete_usecase.dart';
import 'observer/add_marker_observer.dart';
import 'observer/add_user_location_observer.dart';
import 'observer/get_direction_observer.dart';
import 'observer/get_marker_observer.dart';
import 'observer/update_trip_status_completed_observer.dart';

class NavigatePresenter extends Presenter {
  /*location*/
  Function? getUserLocationOnNext;
  Function? getUserLocationOnError;
  Function? getUserLocationOnComplete;

  Function? updateTripStatusOnNext;
  Function? updateTripStatusOnComplete;
  Function? updateTripStatusOnError;

  Function? getDirectionOnNext;
  Function? getDirectionOnError;
  Function? getDirectionOnComplete;

  Function? addMarkerOnError;
  Function? addMarkerOnNext;
  Function? addMarkerOnComplete;

  Function? getMarkerOnError;
  Function? getMarkerOnNext;
  Function? getMarkerOnComplete;

  final AddUserLocationUseCase addUserLocationUseCase;
  final UpdateTripStatusToCompleteUseCase tripStatusToCompleteUseCase;
  final GetDirectionUseCase getDirectionUseCase;
  final AddMarkerUseCase addMarkerUseCase;
  final GetMarkerUseCase getMarkerUseCase;

  NavigatePresenter(
    DataUserLocationRepository repository,
    directionRepository,
    DataMarkerRepository markerRepository,
  )   : addUserLocationUseCase = AddUserLocationUseCase(repository),
        tripStatusToCompleteUseCase =
            UpdateTripStatusToCompleteUseCase(repository),
        getDirectionUseCase = GetDirectionUseCase(directionRepository),
        addMarkerUseCase = AddMarkerUseCase(markerRepository),
        getMarkerUseCase = GetMarkerUseCase(markerRepository);

  @override
  void dispose() {
    addUserLocationUseCase.dispose();
    tripStatusToCompleteUseCase.dispose();
    getDirectionUseCase.dispose();
    addMarkerUseCase.dispose();
    getMarkerUseCase.dispose();
  }

  addUserLocation(double latitude, double longitude) {
    addUserLocationUseCase.execute(
        AddUserLocationUseCaseObserver(this),
        AddUserLocationUseCaseParams(
          latitude,
          longitude,
        ));
  }

  void getDirection(LatLng origin, LatLng destination) {
    return getDirectionUseCase.execute(GetDirectionUseCaseObserver(this),
        GetDirectionUseCaseParams(origin, destination));
  }

  updateStatus(String bookingId, int statusId) {
    tripStatusToCompleteUseCase.execute(UpdateTripStatusCompletedObserver(this),
        UpdateTripStatusToCompleteUseCaseParams(bookingId, statusId));
  }

  addMapMarker(String bookingId, double latitude, double longitude) {
    addMarkerUseCase.execute(AddMarkerUseCaseObserver(this),
        AddMarkerUseCaseParams(bookingId, latitude, longitude));
  }

  void getMapMarker(String bookingId) {
    return getMarkerUseCase.execute(
      GetMarkerUseCaseObserver(this),
      GetMarkerUseCaseParams(bookingId),
    );
  }
}
