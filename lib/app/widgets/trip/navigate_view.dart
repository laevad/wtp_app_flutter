import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constant.dart';
import '../global_custom/nav_route_widget.dart';

const double cameraZoom = 14;

class NavigateView extends StatefulWidget {
  final String? destination;
  final String? source;
  const NavigateView({Key? key, this.destination, this.source})
      : super(key: key);

  @override
  State<NavigateView> createState() => _NavigateViewState();
}

class _NavigateViewState extends State<NavigateView> {
  late LatLng currentLatLng = const LatLng(8.5212429, 124.5747574);
  Completer<GoogleMapController> controller1 = Completer();
  static const LatLng sourceLocation = LatLng(8.5212429, 124.5747574);
  static const LatLng destination = LatLng(8.4734799, 124.6273224);
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

  @override
  void initState() {
    _requestPermission();
    _goToCurrentLocation();
    setState(() {});
    super.initState();
  }

  Future<void> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition();
    currentLatLng = LatLng(position.latitude, position.longitude);

    setState(() {});
    return;
  }

  Future<void> _goToCurrentLocation() async {
    await _determinePosition();
    final GoogleMapController controller2 = await controller1.future;
    controller2.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLatLng, zoom: cameraZoom)));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: Constant.lightColorScheme,
          textTheme: GoogleFonts.openSansTextTheme().apply(
              displayColor: const Color(0xFF383838),
              bodyColor: const Color(0xFF383838)),
          useMaterial3: true),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.lightColorScheme.primaryContainer,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: Container(
                color: Colors.red,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: currentLatLng, zoom: cameraZoom),
                  onMapCreated: (GoogleMapController controller) {
                    controller1.complete(controller);
                  },
                  markers: <Marker>{
                    Marker(
                      draggable: true,
                      markerId: const MarkerId("1"),
                      position: currentLatLng,
                      icon: BitmapDescriptor.defaultMarker,
                      infoWindow: const InfoWindow(
                        title: 'My Location',
                      ),
                    )
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.9,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: NavRouteWidget(
                    btnText: 'Finish',
                    destination: widget.destination,
                    source: widget.source),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
