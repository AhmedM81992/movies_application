import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/browse_tab.dart';
import 'package:movies_app/feature/home/presentation/screens/mobile/mobile_home_tab.dart';
import 'package:movies_app/screens/tabs/search_tab.dart';
import 'package:movies_app/screens/tabs/watch_list_tab.dart';

class MyProvider extends ChangeNotifier {
  int index = 0;
  List<Widget> tabs = [
    MobileHomeTab(),
    SearchTab(),
    const BrowseTab(),
    WatchListTab()
  ];

  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
