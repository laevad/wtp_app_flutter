import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../utils/constant.dart';
import '../edit_profile/edit_profile_view.dart';
import '../login/login_screen.dart';

class SettingsController extends Controller {
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
                onPressed: () {
                  Constant.setSelectedIndex = 0;
                  Navigator.pushReplacementNamed(
                      getContext(), LoginScreen.routeName);
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
  void initListeners() {}
}
