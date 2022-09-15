import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:provider/provider.dart';

import 'app/screens/bottom_nav/bottom_nav_view.dart';
import 'app/screens/edit_profile/edit_profile_view.dart';
import 'app/screens/history/history_view.dart';
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
    WidgetsFlutterBinding.ensureInitialized();
    FlutterCleanArchitecture.debugModeOn();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => null)],
      child: MaterialApp(
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
          HistoryView.routeName: (context) => const HistoryView(),
          HomeView.routeName: (context) => const HomeView(),
          NavigateView.routeName: (context) => const NavigateView(),
        },
      ),
    );
  }
}
