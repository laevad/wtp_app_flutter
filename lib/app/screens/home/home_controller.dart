import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends Controller {
  late LatLng currentLatLng = const LatLng(8.5212429, 124.5747574);
  Completer<GoogleMapController> controller1 = Completer();
  static const LatLng sourceLocation = LatLng(8.5212429, 124.5747574);
  static const LatLng destination = LatLng(8.4734799, 124.6273224);

  LocationData? currentLocation;
  @override
  void initListeners() async {
    _requestPermission();
    await _goToCurrentLocation();
    refreshUI();
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      debugPrint('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition();
    currentLatLng = LatLng(position.latitude, position.longitude);
    refreshUI();
    return;
  }

  Future<void> _goToCurrentLocation() async {
    await _determinePosition();
    final GoogleMapController controller2 = await controller1.future;
    controller2.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLatLng, zoom: 11)));
  }
}
