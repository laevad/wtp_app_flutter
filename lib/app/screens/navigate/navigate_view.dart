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
          return Theme(
            data: Constant.themeData,
            child: Scaffold(
              appBar: AppBar(),
              key: globalKey,
              body: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Container(
                      color: Colors.red,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: controller.currentLatLng,
                            zoom: controller.cameraZoom),
                        onMapCreated: (GoogleMapController mapController) {
                          controller.mapController.complete(mapController);
                        },
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId("current"),
                            position: controller.currentLatLng,
                            icon: BitmapDescriptor.defaultMarker,
                            infoWindow: const InfoWindow(
                              title: 'My Location',
                            ),
                          )
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      );
}