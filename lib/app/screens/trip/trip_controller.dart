import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../navigate/navigate_view.dart';

class MyTripController extends Controller {
  @override
  void initListeners() {}

  void navigate() {
    Navigator.pushNamed(getContext(), NavigateView.routeName);
  }
}
