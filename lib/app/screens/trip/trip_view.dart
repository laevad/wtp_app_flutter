import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/repository/trip/data_trip_repository.dart';
import '../../utils/constant.dart';
import 'trip_controller.dart';

class TripView extends View {
  static String routeName = '/my-trip';
  const TripView({Key? key}) : super(key: key);

  @override
  TripViewState createState() => TripViewState();
}

class TripViewState extends ViewState<TripView, MyTripController> {
  TripViewState() : super(MyTripController(DataTripRepository()));

  @override
  Widget get view => ControlledWidgetBuilder<MyTripController>(
        builder: (context, controller) {
          return Theme(
            data: ThemeData(
                colorScheme: Constant.lightColorScheme,
                textTheme: GoogleFonts.openSansTextTheme().apply(
                    displayColor: const Color(0xFF383838),
                    bodyColor: const Color(0xFF383838)),
                useMaterial3: true),
            child: SafeArea(
              child: Scaffold(
                key: globalKey,
                body: controller.trip == null
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: controller.trip!.length,
                        controller: controller.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            child: ListTile(
                              title: Text(index.toString()),
                            ),
                          );
                        },
                      ),
              ),
            ),
          );
        },
      );
}
