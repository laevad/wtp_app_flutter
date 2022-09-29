import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:wtp_app/app/screens/navigate/navigate_presenter.dart';

import '../../../domain/entities/location.dart';

class NavigateController extends Controller {
  final NavigatePresenter presenter;
  LocationModel? _location;
  LocationModel? get location => _location;
  NavigateController(repository) : presenter = NavigatePresenter(repository);

  /* */
  late LatLng currentLatLng = const LatLng(8.5212429, 124.5747574);
  /* */
  double cameraZoom = 16;
  double cameraTilt = 40;
  double cameraBearing = 30;
  /* */
  final Completer<GoogleMapController> _controller = Completer();
  Completer<GoogleMapController> get mapController => _controller;
  //device location
  loc.LocationData? currentLocation;

  /*stream location*/
  final loc.Location newLoc = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initListeners() {
    /**/
    presenter.getUserLocationOnNext = (LocationModel location) {
      _location = location;
      print("user location on next");
    };
    presenter.getUserLocationOnError = (e) {
      print("User location error ${e.toString()}");
    };
    presenter.getUserLocationOnComplete = () {
      print("user location on complete");
    };
  }

  @override
  void onDisposed() {
    presenter.dispose();
    _locationSubscription?.cancel();
    super.onDisposed();
  }

  @override
  void onInitState() async {
    _requestPermission();
    // _goToCurrentLocation();
    super.onInitState();
  }

  void addLocation() {
    presenter.addUserLocation(12, 12);
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _goToCurrentLocation() async {
    await _determinePosition();

    final GoogleMapController mapControllerLocal = await _controller.future;
    _locationSubscription = newLoc.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      _locationSubscription = null;
      refreshUI();
    }).listen((event) {
      currentLatLng = LatLng(event.latitude!, event.longitude!);
      mapControllerLocal
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          currentLatLng.latitude,
          currentLatLng.longitude,
        ),
        zoom: cameraZoom,
        tilt: cameraTilt,
        bearing: cameraBearing,
      )));
      refreshUI();
    });
    // location.onLocationChanged.listen((event) {
    //   currentLatLng = LatLng(event.latitude!, event.longitude!);
    //
    //   mapControllerLocal
    //       .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //     target: LatLng(
    //       currentLatLng.latitude,
    //       currentLatLng.longitude,
    //     ),
    //     zoom: cameraZoom,
    //     tilt: cameraTilt,
    //     bearing: cameraBearing,
    //   )));
    //   refreshUI();
    // });
  }

  Future<void> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition();
    currentLatLng = LatLng(position.latitude, position.longitude);
    refreshUI();
    return;
  }
}