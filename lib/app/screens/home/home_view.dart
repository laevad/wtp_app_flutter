import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtp_app/app/screens/home/home_controller.dart';

import '../../utils/constant.dart';
import '../../widgets/global_custom/custom_center_appbar.dart';

class HomeView extends View {
  static String routeName = '/Home';
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends ViewState<HomeView, HomeController> {
  HomeViewState() : super(HomeController());

  @override
  Widget get view => ControlledWidgetBuilder<HomeController>(
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
              appBar: const CustomCenterApp(
                title: 'Home',
              ),
            ),
          );
        },
      );
}
