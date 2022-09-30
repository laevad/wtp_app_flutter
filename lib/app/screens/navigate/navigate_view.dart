import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wtp_app/app/screens/navigate/navigate_controller.dart';

import '../../../data/repository/user/data_user_location_repository.dart';
import '../../utils/constant.dart';
import '../../widgets/global_custom/custom_toggle_switch.dart';

class NavigateView extends View {
  static const String routeName = '/navigateView';
  const NavigateView({Key? key}) : super(key: key);

  @override
  NavigateViewState createState() => NavigateViewState();
}

class NavigateViewState extends ViewState<NavigateView, NavigateController> {
  NavigateViewState() : super(NavigateController(DataUserLocationRepository()));

  @override
  Widget get view => ControlledWidgetBuilder<NavigateController>(
        builder: (context, controller) {
          final arguments = (ModalRoute.of(context)?.settings.arguments ??
              <String, dynamic>{}) as Map;
          LatLng sourceLocation = LatLng(
            arguments['fromLatitude'],
            arguments['fromLongitude'],
          );
          LatLng destinationLocation = LatLng(
            arguments['toLatitude'],
            arguments['toLongitude'],
          );

          return Theme(
            data: Constant.themeData,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  TextButton(
                      onPressed: () async {
                        final GoogleMapController mapControllerLocal =
                            await controller.gmController.future;
                        mapControllerLocal
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: sourceLocation,
                            zoom: 14.5,
                            tilt: 50.0,
                          ),
                        ));
                      },
                      child: const Text('SOURCE')),
                  TextButton(
                      onPressed: () async {
                        final GoogleMapController mapControllerLocal =
                            await controller.gmController.future;
                        mapControllerLocal
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: destinationLocation,
                            zoom: 14.5,
                            tilt: 50.0,
                          ),
                        ));
                      },
                      child: const Text('DESTINATION')),
                ],
              ),
              key: globalKey,
              body: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      color: Colors.red,
                      child: GoogleMap(
                        mapToolbarEnabled: false,
                        trafficEnabled: false,
                        tiltGesturesEnabled: true,
                        rotateGesturesEnabled: false,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        polylines: controller.polyLines,
                        mapType: controller.currentMapType,
                        initialCameraPosition: CameraPosition(
                          target: controller.isStart
                              ? controller.currentLatLng
                              : sourceLocation,
                          zoom:
                              controller.isStart ? controller.cameraZoom : 14.5,
                          tilt: controller.cameraTilt,
                          bearing: controller.cameraBearing,
                        ),
                        onMapCreated:
                            (GoogleMapController mapController) async {
                          controller.mapController.complete(mapController);
                          controller.setPolyLines(
                            sourceLocation,
                            destinationLocation,
                            arguments['source'],
                            arguments['destination'],
                          );
                        },
                        markers: controller.markers,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedToggle(
                      values: const ['Track off', 'Track on'],
                      onToggleCallback: (value) {
                        setState(() {
                          controller.toggleValue = value;
                        });
                      },
                      buttonColor: Constant.lightColorScheme.onPrimaryContainer,
                      backgroundColor: Constant.lightColorScheme.surfaceVariant,
                      textColor: const Color(0xFFFFFFFF),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: FloatingActionButton(
                              heroTag: "btn2",
                              backgroundColor: Colors.green,
                              onPressed: () => controller.changeMapType(),
                              child: const Icon(
                                Icons.map,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: FloatingActionButton(
                              backgroundColor: Colors.purple,
                              onPressed: () async => controller.addMarker(),
                              child: const Icon(
                                Icons.add_location,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
