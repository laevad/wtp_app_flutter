import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:wtp_app/app/screens/navigate/navigate_presenter.dart';

import '../bottom_nav/bottom_nav_view.dart';

class NavigateController extends Controller {
  static int num = 1;
  int toggleValue = 0;
  final NavigatePresenter presenter;

  NavigateController(repository) : presenter = NavigatePresenter(repository);

  /* */
  late LatLng currentLatLng = const LatLng(8.5212429, 124.5747574);
  /* */
  double cameraZoom = 16;
  double cameraTilt = 50;
  double cameraBearing = 30;

  /* */
  final Completer<GoogleMapController> gmController = Completer();
  Completer<GoogleMapController> get mapController => gmController;
  //device location
  loc.LocationData? currentLocation;
  /* markers */
  final Set<Marker> markers = <Marker>{};

  /*stream location*/
  final loc.Location newLoc = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  PolylinePoints? polylinePoints;
  List<LatLng> polyLineCoordinates = [];
  final Set<Polyline> polyLines = <Polyline>{};

  /* bool */
  final bool _isStart = false;
  bool get isStart => _isStart;

  /* map type */
  MapType _currentMapType = MapType.normal;
  MapType get currentMapType => _currentMapType;
  @override
  void initListeners() {
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
      toggleValue == 1
          ? mapControllerLocal
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(
                currentLatLng.latitude,
                currentLatLng.longitude,
              ),
              zoom: 17.5,
              tilt: cameraTilt,
              bearing: cameraBearing,
            )))
          : null;

      refreshUI();
    });
  }

  void setPolyLines(LatLng sourceLocation, LatLng destinationLocation,
      String source, String destination) async {
    PolylineResult? result = await polylinePoints?.getRouteBetweenCoordinates(
      "AIzaSyAzra1o8YI_Wiurg5N_qB1BGA4BffCPN94",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    if (result?.status == 'OK') {
      for (var point in result!.points) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      polyLines.add(
        Polyline(
            polylineId: const PolylineId('polyLine'),
            color: const Color(0xFF5008CB),
            points: polyLineCoordinates,
            width: 6),
      );
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
    refreshUI();
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
        title: 'My Location',
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
    refreshUI();
  }

  void updateStatus() {}
}
