import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wtp_app/app/screens/home/home_controller.dart';

import '/app/utils/constant.dart';

class HomeScreen extends View {
  static String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ViewState<HomeScreen, HomeController> {
  HomeScreenState() : super(HomeController());

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
      child:  ControlledWidgetBuilder<HomeController>(builder: (context, controller) {
          return Scaffold(
            body: controller.pages[controller.selectedIndex],
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
                borderRadius: BorderRadius.only(topRight: Radius.circular(14), topLeft: Radius.circular(14)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: GNav(
                  onTabChange: (index){
                    debugPrint("selected tab: ${index.toString()}");
                    controller.navigateBottomBar(index);
                  },
                  gap: 8,
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.transparent,
                  color: Colors.white ,
                  activeColor: Colors.white,
                  tabBackgroundColor: Colors.white38,
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home',),
                    GButton(icon: Icons.favorite_border, text: 'Likes',),
                    GButton(icon: Icons.search, text: 'Search',),
                    GButton(icon: Icons.settings, text: 'Settings',),
                  ],
                ),
              ),
            ),
          );
        },),

    );
  }
}

