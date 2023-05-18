import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;
import 'package:google_nav_bar/google_nav_bar.dart';


import '../../utils/constant.dart';
import 'bottom_nav_controller.dart';

class BottomNavView extends clean_architecture.View {
  static String routeName = '/bottom-nav-view';
  const BottomNavView({Key? key}) : super(key: key);

  @override
  BottomNavViewState createState() => BottomNavViewState();
}

class BottomNavViewState extends clean_architecture.ViewState<BottomNavView, HomeController> {
  BottomNavViewState() : super(HomeController());

  @override
  Widget get view {
    return clean_architecture.ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        return Scaffold(
          body: PageView(
            controller: controller.pageController,
            children: Constant.pages,
            onPageChanged: (index) async {
              controller.setSelectedIndex = index;
              controller.navigateBottomBar(index);
            },
          ),
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
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: GNav(
                selectedIndex: controller.selectedIndex,
                onTabChange: (index) {
                  debugPrint("selected tab: ${index.toString()}");
                  controller.navigateBottomBar(index);
                  controller.pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.linear);
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
    );
  }
}
