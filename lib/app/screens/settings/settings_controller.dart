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
          content:
              const Text('Would you really want to log out from this page?'),
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
    presenter.logoutOnComplete = () {
      print("logout on complete");
      EasyLoading.dismiss();
      Constant.setSelectedIndex = 0;
      Navigator.pushReplacementNamed(getContext(), LoginScreen.routeName);
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
