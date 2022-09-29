import 'dart:async';
import 'dart:ui';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
    await _determinePosition();

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
      mapControllerLocal
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          currentLatLng.latitude,
          currentLatLng.longitude,
        ),
        zoom: 16.5,
        tilt: cameraTilt,
        bearing: cameraBearing,
      )));

      refreshUI();
    });
  }

  Future<void> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition();
    currentLatLng = LatLng(position.latitude, position.longitude);
    refreshUI();
    return;
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
            color: const Color(0xD7CB0835),
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
}
