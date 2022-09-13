import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '/app/utils/constant.dart';
import 'bottom_nav_controller.dart';

class BottomNavView extends View {
  static String routeName = '/bottom-nav-view';
  const BottomNavView({Key? key}) : super(key: key);

  @override
  BottomNavViewState createState() => BottomNavViewState();
}

class BottomNavViewState extends ViewState<BottomNavView, HomeController> {
  BottomNavViewState() : super(HomeController());

  @override
  Widget get view {
    return Theme(
      data: ThemeData(
        colorScheme: Constant.lightColorScheme,
        textTheme: GoogleFonts.openSansTextTheme().apply(
            displayColor: const Color(0xFF383838),
            bodyColor: const Color(0xFF383838)),
        useMaterial3: true,
      ),
      child: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return Scaffold(
            body: Constant.pages[Constant.selectedIndex],
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [
                    0.20,
                    0.90,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFFB578E),
                    Color(0xFFFDA58E),
                  ],
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    topLeft: Radius.circular(18)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: GNav(
                  onTabChange: (index) {
                    debugPrint("selected tab: ${index.toString()}");
                    controller.navigateBottomBar(index);
                  },
                  gap: 8,
                  padding: const EdgeInsets.all(14),
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                  activeColor: Colors.black54,
                  tabBackgroundColor: Colors.white38,
                  tabs: Constant.icons,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
