import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/app/screens/server_url/server_view.dart';

import '../../../domain/entities/auth_token.dart';
import '../../navigator/bottom_nav/bottom_nav_view.dart';
import '../../utils/constant.dart';
import 'login_presenter.dart';

class LoginController extends Controller {
  LoginPresenter? loginPresenter;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthToken? _authToken;

  AuthToken? get getAuthToken => _authToken;

  LoginController(loginDetailsRepository)
      : loginPresenter = LoginPresenter(loginDetailsRepository),
        super();

  @override
  void initListeners() {
    Constant.configLoading();
    loginPresenter!.getAuthTokenOnNext = (AuthToken loginDetails) async {
      _authToken = loginDetails;
      if (loginDetails.statusCode == 401) {
        EasyLoading.showError(loginDetails.invalidCred.toString());
      }
      if (loginDetails.statusCode == 200) {
        Future.delayed(const Duration(milliseconds: 10)).then((value) async {
          EasyLoading.showSuccess('User was successfully login!');
        });

        Future.delayed(const Duration(milliseconds: 2250)).then((value) async {
          Navigator.pushReplacementNamed(getContext(), BottomNavView.routeName);
        });
      }

      EasyLoading.dismiss();
    };
    loginPresenter!.getAuthTokenOnComplete = () async {
      print("auth on complete");
      refreshUI();
    };

    loginPresenter!.getAuthTokenOnError = (e) {
      print("auth on error");
      print(e);
      ScaffoldMessenger.of(getContext()).hideCurrentSnackBar();
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(
          content: Text("Invalid credentials/Prohibited Account")));

      EasyLoading.dismiss();
    };

    refreshUI();
  }

  login() async {
    FocusScope.of(getContext()).unfocus();
    EasyLoading.show(status: 'loading...');
    loginPresenter!.login(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  void serverUrlSettings() {
    Navigator.pushNamed(getContext(), ServerView.routeName);
  }

  @override
  void onDisposed() {
    loginPresenter?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onDisposed();
  }
}
