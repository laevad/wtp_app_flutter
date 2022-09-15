import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtp_app/app/widgets/my_trip/trip_custom_expand_tile.dart';

import '../../utils/constant.dart';
import 'trip_controller.dart';

class TripView extends View {
  static String routeName = '/my-trip';
  const TripView({Key? key}) : super(key: key);

  @override
  TripViewState createState() => TripViewState();
}

class TripViewState extends ViewState<TripView, MyTripController> {
  TripViewState() : super(MyTripController());

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
            child: Scaffold(
              key: globalKey,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: ListView.builder(
                    itemCount: 1,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return TripCustomExpandTile(
                          index: (index + 1).toString());
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
}
