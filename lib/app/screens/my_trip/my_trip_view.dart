import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant.dart';
import '../../widgets/global_custom/custom_center_appbar.dart';
import 'my_trip_controller.dart';

class MyTripView extends View {
  static String routeName = '/my-trip';
  const MyTripView({Key? key}) : super(key: key);

  @override
  MyTripViewState createState() => MyTripViewState();
}

class MyTripViewState extends ViewState<MyTripView, MyTripController> {
  MyTripViewState() : super(MyTripController());

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
              appBar: const CustomCenterApp(
                title: 'My Trip',
              ),
              key: globalKey,
            ),
          );
        },
      );
}
