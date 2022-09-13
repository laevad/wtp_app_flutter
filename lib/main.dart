import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:provider/provider.dart';

import '/app/screens/edit_profile/edit_profile_view.dart';
import '/app/screens/home/home_screen.dart';
import '/app/screens/login/login_screen.dart';

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
          HomeScreen.routeName: (context) => const HomeScreen(),
          EditProfileView.routeName: (context) => const EditProfileView(),
        },
      ),
    );
  }
}
