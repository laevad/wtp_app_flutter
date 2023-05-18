import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;
import 'package:page_transition/page_transition.dart';

import '../../../data/repository/auth/data_auth_token_repository.dart';
import '../../navigator/bottom_nav/bottom_nav_view.dart';
import '../../utils/constant.dart';
import '../login/login_screen.dart';
import 'splash_controller.dart';

class SplashView extends clean_architecture.View {
  static String routeName = '/splash';
  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends clean_architecture.ViewState<SplashView, SplashController> {
  SplashViewState() : super(SplashController(DataAuthRepository()));

  @override
  Widget get view => clean_architecture.ControlledWidgetBuilder<SplashController>(
        builder: (context, controller) {
          return AnimatedSplashScreen.withScreenFunction(
            splash: 'assets/images/logo.png',
            animationDuration: const Duration(seconds: 1),
            duration: 1,
            screenFunction: () async {
              return controller.isAuth == false
                  ? const LoginScreen()
                  : const BottomNavView();
            },
            splashTransition: SplashTransition.rotationTransition,
            pageTransitionType: PageTransitionType.bottomToTop,
            curve: Curves.bounceInOut,
            backgroundColor: Constant.lightColorScheme.tertiaryContainer,
            splashIconSize: 100,
          );
        },
      );
}
