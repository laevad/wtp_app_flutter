import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/utils/constant.dart';

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

  @override
  void initListeners() {
    // TODO: implement initListeners
  }
}
