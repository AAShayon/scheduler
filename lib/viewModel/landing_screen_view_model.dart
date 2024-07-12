import 'package:flutter/material.dart';

class LandingScreenViewModel extends ChangeNotifier {

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;


  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
  void goBackToPreviousIndex() {
    if (_currentIndex > 0) {
      _currentIndex = 0;
      notifyListeners();
    }
  }
}