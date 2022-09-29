import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wtp_app/app/screens/navigate/navigate_controller.dart';

import '../../../data/repository/user/data_user_location_repository.dart';
import '../../utils/constant.dart';

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
          final bound = LatLngBounds(
            southwest: sourceLocation,
            northeast: destinationLocation,
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
                        zoomControlsEnabled: false,
                        polylines: controller.polyLines,
                        mapType: MapType.normal,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, right: 12),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        backgroundColor: Colors.red,
                        onPressed: () async {
                          final GoogleMapController mapControllerLocal =
                              await controller.gmController.future;
                          mapControllerLocal.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                  LatLngBounds(
                                      southwest: sourceLocation,
                                      northeast: destinationLocation),
                                  50.0));
                        },
                        child: const Icon(
                          Icons.center_focus_strong,
                          color: Colors.white,
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
