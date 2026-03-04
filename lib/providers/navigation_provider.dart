import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  String _currentRoute = '/login';

  int get currentIndex => _currentIndex;
  String get currentRoute => _currentRoute;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}
