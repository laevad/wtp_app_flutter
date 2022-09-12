import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:flutter/cupertino.dart';
import 'package:wtp_app/app/utils/constant.dart';

class HomeController extends Controller{

  void navigateBottomBar(int index){
   Constant.setSelectedIndex = index;
    refreshUI();
  }

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

}