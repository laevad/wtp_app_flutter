import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/app/screens/settings/setting_presenter.dart';

import '../../utils/constant.dart';
import '../edit_profile/edit_profile_view.dart';
import '../login/login_screen.dart';

class SettingsController extends Controller {
  final SettingsPresenter presenter;
  SettingsController() : presenter = SettingsPresenter();

  void logout() {
    showDialog(
      context: getContext(),
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you really want to logout?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(getContext());
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () async {
                  EasyLoading.show(status: 'loading...');
                  presenter.logout();
                },
                child: const Text('Log out')),
          ],
        );
      },
    );
  }

  void editProfile() {
    Navigator.pushNamed(getContext(), EditProfileView.routeName);
  }

  @override
  void initListeners() {
    Constant.configLoading();
    presenter.logoutOnNext = () {
      print("logout on next");
      refreshUI();
    };
    presenter.logoutOnComplete = () async {
      print("logout on complete");
      Navigator.of(getContext()).pop();
      Future.delayed(const Duration(milliseconds: 499)).then((value) {});
      await EasyLoading.showSuccess('User was successfully logout!');
      Future.delayed(const Duration(milliseconds: 2250)).then((value) {
        Constant.setSelectedIndex = 0;
        Navigator.pushReplacementNamed(getContext(), LoginScreen.routeName);
      });
    };
    presenter.logoutOnError = (e) {
      print("logout on error");
      print(e);
      Navigator.of(getContext()).pop();
      ScaffoldMessenger.of(getContext()).hideCurrentSnackBar();
      ScaffoldMessenger.of(getContext()).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}, Please try again")));
      EasyLoading.dismiss();
    };

    refreshUI();
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
