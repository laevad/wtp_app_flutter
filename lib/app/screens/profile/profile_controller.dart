import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../utils/constant.dart';
import '../edit_profile/edit_profile_view.dart';
import '../login/login_screen.dart';

class ProfileController extends Controller {
  void logout() {
    Constant.setSelectedIndex = 0;
    Navigator.pushReplacementNamed(getContext(), LoginScreen.routeName);
  }

  void editProfile() {
    Navigator.pushNamed(getContext(), EditProfileView.routeName);
  }

  @override
  void initListeners() {}
}
