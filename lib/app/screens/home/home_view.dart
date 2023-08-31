import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'home_controller.dart';

class HomeView extends CleanView {
  static String routeName = '/Home';
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends CleanViewState<HomeView, HomeController> {
  HomeViewState() : super(HomeController());

  @override
  Widget get view => ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return Scaffold(
            key: globalKey,
            body: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:
                  CameraPosition(target: controller.currentLatLng, zoom: 11),
              onMapCreated: (GoogleMapController controller1) {
                controller.controller1.complete(controller1);
              },
              markers: <Marker>{
                Marker(
                  draggable: true,
                  markerId: const MarkerId("1"),
                  position: controller.currentLatLng,
                  icon: BitmapDescriptor.defaultMarker,
                  infoWindow: const InfoWindow(
                    title: 'My Location',
                  ),
                )
              },
            ),
          );
        },
      );
}
