import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant.dart';
import '../../widgets/global_custom/nav_route_widget.dart';
import 'navigate_controller.dart';

class NavigateView extends View {
  static String routeName = 'NavigateView';
  const NavigateView({Key? key}) : super(key: key);

  @override
  State<NavigateView> createState() => NavigateViewState();
}

class NavigateViewState extends ViewState<NavigateView, NavigateController> {
  NavigateViewState() : super(NavigateController());

  @override
  Widget get view => ControlledWidgetBuilder<NavigateController>(
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
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              body: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4.7,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: NavRouteWidget(
                        btnText: 'Finish',
                        destination: 'Davao',
                        source: 'CDO',
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
