import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/app/screens/add_expense/add_expense_view.dart';

import 'app/navigator/bottom_nav/bottom_nav_view.dart';
import 'app/screens/edit_profile/edit_profile_view.dart';
import 'app/screens/home/home_view.dart';
import 'app/screens/incentives/incentives_view.dart';
import 'app/screens/login/login_screen.dart';
import 'app/screens/navigate/navigate_view.dart';
import 'app/screens/server_url/server_view.dart';
import 'app/screens/splash/splash_view.dart';
import 'app/screens/trip/trip_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterCleanArchitecture.debugModeOn();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'WT&P Management System',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        BottomNavView.routeName: (context) => const BottomNavView(),
        EditProfileView.routeName: (context) => const EditProfileView(),
        TripView.routeName: (context) => const TripView(),
        IncentivesView.routeName: (context) => const IncentivesView(),
        HomeView.routeName: (context) => const HomeView(),
        ServerView.routeName: (context) => const ServerView(),
        NavigateView.routeName: (context) => const NavigateView(),
        AddExpenseView.routeName: (context) => const AddExpenseView()
      },
    );
  }
}
