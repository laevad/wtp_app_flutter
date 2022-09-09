import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:flutter/cupertino.dart';

class HomeController extends Controller{

  late int _selectedIndex =0 ;
  final List <Widget> _pages = const[
    Center(child: Text('Hello 1'),),
    Center(child: Text('Hello 2'),),
    Center(child: Text('Hello 3'),),
    Center(child: Text('Hello 4'),),
  ];


  int get selectedIndex => _selectedIndex;

  List<Widget> get pages => _pages;


  void navigateBottomBar(int index){
    _selectedIndex = index;
    refreshUI();
  }

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

}