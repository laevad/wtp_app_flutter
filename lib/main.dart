import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/incentives/incentives_view.dart';

import 'app/screens/bottom_nav/bottom_nav_view.dart';
import 'app/screens/edit_profile/edit_profile_view.dart';
import 'app/screens/home/home_view.dart';
import 'app/screens/login/login_screen.dart';
import 'app/screens/navigate/navigate_view.dart';
import 'app/screens/trip/trip_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WT&P Management System',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        BottomNavView.routeName: (context) => const BottomNavView(),
        EditProfileView.routeName: (context) => const EditProfileView(),
        TripView.routeName: (context) => const TripView(),
        IncentivesView.routeName: (context) => const IncentivesView(),
        HomeView.routeName: (context) => const HomeView(),
        NavigateView.routeName: (context) => const NavigateView(),
      },
    );
  }
}
