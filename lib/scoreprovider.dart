import 'package:flutter/cupertino.dart';

class Score extends ChangeNotifier {
  int score = 0;

  void increment() {
    score++;
    notifyListeners();
  }

  void reset() {
    score = 0;
    notifyListeners();
  }
}
