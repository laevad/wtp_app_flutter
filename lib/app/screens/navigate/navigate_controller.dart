import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:wtp_app/app/screens/navigate/navigate_presenter.dart';
import 'package:wtp_app/data/repository/helpers/auth/is_auth.dart';
import 'package:wtp_app/domain/entities/direction.dart';
import 'package:wtp_app/domain/entities/map_marker.dart';
import 'package:wtp_app/domain/repositories/direction/direction_repository.dart';

import '../../../device/repository/data_marker_repository.dart';
import '../../navigator/bottom_nav/bottom_nav_view.dart';
import '../../utils/constant.dart';

class NavigateController extends Controller {
  static int num = 1;
  int toggleValue = 0;
  final NavigatePresenter presenter;

  NavigateController(repository, DirectionRepository directionRepository,
      DataMarkerRepository markerRepository)
      : presenter = NavigatePresenter(
            repository, directionRepository, markerRepository);

  /* */
  late LatLng currentLatLng = const LatLng(8.5212429, 124.5747574);
  /* */
  double cameraZoom = 17.5;
  double cameraTilt = 50;
  double cameraBearing = 30;

  /* */
  final Completer<GoogleMapController> gmController = Completer();
  Completer<GoogleMapController> get mapController => gmController;
  //device location
  loc.LocationData? currentLocation;

  /*stream location*/
  final loc.Location newLoc = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  /*poly line */
  PolylinePoints? polylinePoints;
  List<LatLng> polyLineCoordinates = [];
  final Set<Polyline> polyLines = <Polyline>{};
  /* markers */
  final Set<Marker> markers = <Marker>{};

  /* map type */
  MapType _currentMapType = MapType.normal;
  MapType get currentMapType => _currentMapType;

  /* get direction */
  late final Directions _directions;
  Directions? get directions => _directions;

  /* list of markers from server */
  List<MapMarker>? _mapMarker;
  List<MapMarker>? get mapMarker => _mapMarker;

  @override
  void initListeners() {
    Constant.configLoading();
    /**/
    presenter.getUserLocationOnNext = () {
      print("user location on next");
    };
    presenter.getUserLocationOnError = (e) {
      print("User location error ${e.toString()}");
    };
    presenter.getUserLocationOnComplete = () {
      print("user location on complete");
    };

    presenter.updateTripStatusOnNext = (res) {
      print("trip update completed status on next");
    };
    presenter.updateTripStatusOnComplete = () {
      print("trip update completed status on complete");
    };
    presenter.updateTripStatusOnError = (e) {
      print("trip update completed status on error: ${e.toString()}");
    };

    /* get direction */
    presenter.getDirectionOnNext = (Directions directions) async {
      _directions = directions;
      polyLines.add(Polyline(
        polylineId: const PolylineId('overview_polyline'),
        // color: const Color(0xFF5008CB),
        color: Colors.red,
        width: 7,
        points: directions.polylinePoints!
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList(),
      ));
      EasyLoading.dismiss();
      print("get direction on next");
    };
    presenter.getDirectionOnError = (e) {
      print("get direction on error: ${e.toString()}");
    };
    presenter.getDirectionOnComplete = () {
      print("get direction on complete");
    };

    /* add marker */
    presenter.addMarkerOnError = (e) {
      print("add marker on error: ${e.toString()}");
      EasyLoading.dismiss();
    };
    presenter.addMarkerOnNext = (MapMarker mapMarker) {
      print("add marker on next");
      EasyLoading.dismiss();
      refreshUI();
    };
    presenter.addMarkerOnComplete = () {
      print("add marker complete");
      EasyLoading.dismiss();
    };

    /* get marker */

    presenter.getMarkerOnError = (e) {
      print("get marker on error: ${e.toString()}");
    };
    presenter.getMarkerOnNext = (MapMarkerModel marker) {
      _mapMarker = marker.mapMarker;
      if (_mapMarker != null) {
        for (int i = 0; i < _mapMarker!.length; i++) {
          markers.add(Marker(
            markerId: MarkerId(_mapMarker![i].id.toString()),
            position:
                LatLng(_mapMarker![i].latitude!, _mapMarker![i].longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta),
          ));
        }
      }
      print("get marker on next");
      refreshUI();
    };
    presenter.getMarkerOnComplete = () {
      print("get marker on complete");
    };
  }

  @override
  void onDisposed() {
    presenter.dispose();
    _locationSubscription?.cancel();
    _locationSubscription = null;
    super.onDisposed();
  }

  @override
  void onInitState() async {
    _requestPermission();
    goToCurrentLocation();

    polylinePoints = PolylinePoints();
    super.onInitState();
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

  Future<void> goToCurrentLocation() async {
    final GoogleMapController mapControllerLocal = await gmController.future;
    _locationSubscription = newLoc.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      _locationSubscription = null;
      refreshUI();
    }).listen((event) {
      markers.add(Marker(
        markerId: const MarkerId("current"),
        position: currentLatLng,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: 'My Location',
        ),
      ));
      currentLatLng = LatLng(event.latitude!, event.longitude!);
      addLocationTo(latitude: event.latitude!, longitude: event.longitude!);
      if (toggleValue == 1) {
        updateStatus();
        mapControllerLocal
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
            currentLatLng.latitude,
            currentLatLng.longitude,
          ),
          zoom: 17.5,
          tilt: cameraTilt,
          bearing: cameraBearing,
        )));
      } else {
        null;
      }

      refreshUI();
    });
  }

  void changeMapType() {
    refreshUI();
    _currentMapType =
        _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
  }

  void cancelLive() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  void addMarker() {
    markers.add(Marker(
      markerId: MarkerId("${num++}"),
      position: currentLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      infoWindow: const InfoWindow(
        title: 'Drop',
      ),
    ));
    refreshUI();
  }

  void addLocationTo({required double latitude, required double longitude}) {
    presenter.addUserLocation(latitude, longitude);
  }

  void backToHome({required String bookingId, required int statusId}) {
    presenter.updateStatus(bookingId, statusId);
    Navigator.pushReplacementNamed(getContext(), BottomNavView.routeName);
  }

  void back() {
    Navigator.pushReplacementNamed(getContext(), BottomNavView.routeName);
  }

  void getDirection(LatLng origin, LatLng destination) {
    presenter.getDirection(
        LatLng(origin.latitude, origin.longitude),
        LatLng(
          destination.latitude,
          destination.longitude,
        ));
  }

  void addOriginDestinationMarker(LatLng sourceLocation,
      LatLng destinationLocation, String source, String destination) {
    markers.add(Marker(
      markerId: const MarkerId("source"),
      position: sourceLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(
        title: source,
      ),
    ));
    markers.add(Marker(
      markerId: const MarkerId("destination"),
      position: destinationLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow: InfoWindow(
        title: destination,
      ),
    ));
  }

  /* add marker */
  void addMapMarker(String bookingId) async {
    await presenter.addMapMarker(
      bookingId,
      currentLatLng.latitude,
      currentLatLng.longitude,
    );
  }

  /* get marker */
  void getMarker(String bookingId) {
    presenter.getMapMarker(bookingId);
  }

  Future<void> updateStatus() async {
    presenter.updateStatus(await IsAuth.getData('bookingId'), 3);
  }
}
