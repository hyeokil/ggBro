import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  MainProvider();

  late String isMenuSelected = 'main';

  void menuSelected(String SelectedMenu) {
    isMenuSelected = SelectedMenu;
    notifyListeners();
  }
}