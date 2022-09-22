import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../domain/entities/auth_token.dart';
import '../../utils/constant.dart';
import '../bottom_nav/bottom_nav_view.dart';
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
    loginPresenter!.getAuthTokenOnNext = (AuthToken loginDetails) {
      print("auth on next");
      _authToken = loginDetails;
      refreshUI();
    };
    loginPresenter!.getAuthTokenOnComplete = () {
      print("auth on complete");
      EasyLoading.dismiss();
      Navigator.pushNamedAndRemoveUntil(getContext(), BottomNavView.routeName,
          (Route<dynamic> route) => false);
    };

    loginPresenter!.getAuthTokenOnError = (e) {
      print("auth on error");
      print(e);
      if (emailController.text.isEmpty && passwordController.text.isEmpty) {
        ScaffoldMessenger.of(getContext()).hideCurrentSnackBar();
        ScaffoldMessenger.of(getContext()).showSnackBar(
            const SnackBar(content: Text('Email & Pass field is required')));
      } else if (emailController.text.isEmpty &&
          passwordController.text.isNotEmpty) {
        ScaffoldMessenger.of(getContext()).hideCurrentSnackBar();
        ScaffoldMessenger.of(getContext()).showSnackBar(
            const SnackBar(content: Text('Email field is required')));
      } else if (passwordController.text.isEmpty &&
          emailController.text.isNotEmpty) {
        ScaffoldMessenger.of(getContext()).hideCurrentSnackBar();
        ScaffoldMessenger.of(getContext()).showSnackBar(
            const SnackBar(content: Text('Password field is required')));
      } else {
        ScaffoldMessenger.of(getContext()).hideCurrentSnackBar();
        ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(
            content: Text('Invalid credentials, please check your input')));
      }
      EasyLoading.dismiss();
    };

    refreshUI();
  }

  login() async {
    EasyLoading.show(status: 'loading...');
    loginPresenter!.login(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  void onDisposed() {
    loginPresenter?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onDisposed();
  }
}
