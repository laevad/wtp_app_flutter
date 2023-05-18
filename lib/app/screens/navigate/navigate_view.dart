import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/repository/user/data_user_location_repository.dart';
import '../../../device/repository/data_direction_repository.dart';
import '../../../device/repository/data_marker_repository.dart';
import '../../utils/constant.dart';
import '../../widgets/global_custom/custom_appbar.dart';
import '../../widgets/global_custom/custom_toggle_switch.dart';
import 'navigate_controller.dart';

class NavigateView extends clean_architecture.View {
  static const String routeName = '/navigateView';
  const NavigateView({Key? key}) : super(key: key);

  @override
  NavigateViewState createState() => NavigateViewState();
}

class NavigateViewState extends clean_architecture.ViewState<NavigateView, NavigateController> {
  NavigateViewState()
      : super(NavigateController(
          DataUserLocationRepository(),
          DataDirectionRepository(),
          DataMarkerRepository(),
        ));

  @override
  Widget get view => clean_architecture.ControlledWidgetBuilder<NavigateController>(
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

          String source = arguments['source'];
          String destination = arguments['destination'];
          String bookingId = arguments['bookingId'];

          String status = arguments['status'];

          if (status == 'completed') {
            controller.cancelLive();
          }

          // IsAuth.deleteKey(key: 'bookingId');
          // IsAuth.setToken(key: 'bookingId', value: bookingId);
          return Theme(
            data: Constant.themeData,
            child: Scaffold(
              appBar: CustomAppBar(
                onPressed: () => controller.back(),
                actions: [
                  TextButton(
                      onPressed: () async {
                        final GoogleMapController mapControllerLocal =
                            await controller.gmController.future;
                        mapControllerLocal
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: sourceLocation,
                            zoom: controller.cameraZoom,
                            tilt: controller.cameraTilt,
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
                            zoom: controller.cameraZoom,
                            tilt: controller.cameraTilt,
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
                        polylines: controller.polyLines,
                        mapType: controller.currentMapType,
                        initialCameraPosition: CameraPosition(
                          target: sourceLocation,
                          zoom: controller.cameraZoom,
                          tilt: controller.cameraTilt,
                          bearing: controller.cameraBearing,
                        ),
                        onMapCreated:
                            (GoogleMapController mapController) async {
                          if (status != 'completed') {}
                          controller.mapController.complete(mapController);
                          controller.getDirection(
                              sourceLocation, destinationLocation);
                          controller.addOriginDestinationMarker(sourceLocation,
                              destinationLocation, source, destination);
                          controller.getMarker(bookingId);
                        },
                        markers: controller.markers,
                      ),
                    ),
                  ),
                  status != 'Completed'
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: AnimatedToggle(
                            values: const ['off', 'on'],
                            onToggleCallback: (value) {
                              setState(() {
                                controller.toggleValue = value;
                              });
                            },
                            buttonColor:
                                Constant.lightColorScheme.onPrimaryContainer,
                            backgroundColor:
                                Constant.lightColorScheme.surfaceVariant,
                            textColor: const Color(0xFFFFFFFF),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: FloatingActionButton(
                              heroTag: "btn0",
                              backgroundColor: Colors.blue,
                              onPressed: () async {
                                final GoogleMapController mapControllerLocal =
                                    await controller.gmController.future;
                                mapControllerLocal.animateCamera(
                                  CameraUpdate.newLatLngBounds(
                                      controller.directions!.bounds!, 75.0),
                                );
                              },
                              child: const Icon(
                                Icons.center_focus_strong,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
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
                          status != 'Completed'
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
                                  child: FloatingActionButton(
                                    heroTag: 'addLo',
                                    backgroundColor: Colors.purple,
                                    onPressed: () async {
                                      controller.addMapMarker(bookingId);
                                      controller.addMarker();
                                    },
                                    child: const Icon(
                                      Icons.add_location,
                                      color: Colors.white,
                                      size: 45,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  status != 'Completed'
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: controller.isMark
                                ? ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                    ),
                                    onPressed: () => controller.backToHome(
                                        bookingId: arguments['bookingId'],
                                        statusId: 2),
                                    // onPressed: () => {},
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 40),
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      );
}
