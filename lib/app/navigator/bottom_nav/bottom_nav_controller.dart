import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constant.dart';

class HomeController extends Controller {
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  int _selectedIndex = 0;
  get selectedIndex => _selectedIndex;
  set setSelectedIndex(int index) => _selectedIndex = index;

  void navigateBottomBar(int index) {
    Constant.setSelectedIndex = index;
    refreshUI();
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  @override
  void onInitState() {
    _requestPermission();
    super.onInitState();
  }
}
